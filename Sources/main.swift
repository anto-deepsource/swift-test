import CryptoSwift

let blockMode = ECB() // Use of `ECB` is not safe
_ = try AES(key: key, blockMode: blockMode, padding: padding)


func foo() {
        if true {}
        else if true {}
        else if true {}
        else if true {}
        else if true {}
        else {}
}

func makeRoute(url: URL) -> Route? {
        guard let urlScanner = URLScanner(url: url) else { return nil }

        if urlScanner.isOurScheme, let host = DeeplinkInput.Host(rawValue: urlScanner.host.lowercased()) {
            let urlQuery = urlScanner.value(query: "url")?.asURL
            // Unless the `open-url` URL specifies a `private` parameter,
            // use the last browsing mode the user was in.
            let isPrivate = Bool(urlScanner.value(query: "private") ?? "") ?? isPrivate

            recordTelemetry(input: host, isPrivate: isPrivate)

            switch host {
            case .deepLink:
                let deepLinkURL = urlScanner.value(query: "url")?.lowercased()
                let paths = deepLinkURL?.split(separator: "/") ?? []
                guard let pathRaw = paths[safe: 0].flatMap(String.init),
                      let path = DeeplinkInput.Path(rawValue: pathRaw),
                      let subPath = paths[safe: 1].flatMap(String.init)
                else { return nil }
                if path == .settings, let subPath = Route.SettingsSection(rawValue: subPath) {
                    return .settings(section: subPath)
                } else if path == .homepanel, let subPath = Route.HomepanelSection(rawValue: subPath) {
                    return .homepanel(section: subPath)
                } else if path == .defaultBrowser, let subPath = Route.DefaultBrowserSection(rawValue: subPath) {
                    return .defaultBrowser(section: subPath)
                } else if path == .action, let subPath = Route.AppAction(rawValue: subPath) {
                    return .action(action: subPath)
                } else {
                    return nil
                }

            case .fxaSignIn where urlScanner.value(query: "signin") != nil:
                return .fxaSignIn(params: FxALaunchParams(entrypoint: .fxaDeepLinkNavigation, query: url.getQuery()))

            case .openUrl:
                return .search(url: urlQuery, isPrivate: isPrivate)

            case .openText:
                return .searchQuery(query: urlScanner.value(query: "text") ?? "")

            case .glean:
                    return .glean(url: url)

            case .widgetMediumTopSitesOpenUrl:
                // Widget Top sites - open url
                return .search(url: urlQuery, isPrivate: isPrivate)

            case .widgetSmallQuickLinkOpenUrl:
                // Widget Quick links - small - open url private or regular
                return .search(url: urlQuery, isPrivate: isPrivate)

            case .widgetMediumQuickLinkOpenUrl:
                // Widget Quick Actions - medium - open url private or regular
                return .search(url: urlQuery, isPrivate: isPrivate)

            case .widgetSmallQuickLinkOpenCopied, .widgetMediumQuickLinkOpenCopied:
                // Widget Quick links - medium - open copied url
                if !UIPasteboard.general.hasURLs {
                    let searchText = UIPasteboard.general.string ?? ""
                    return .searchQuery(query: searchText)
                } else {
                    let url = UIPasteboard.general.url
                    return .search(url: url, isPrivate: isPrivate)
                }

            case .widgetSmallQuickLinkClosePrivateTabs, .widgetMediumQuickLinkClosePrivateTabs:
                // Widget Quick links - medium - close private tabs
                return .action(action: .closePrivateTabs)

            case .widgetTabsMediumOpenUrl:
                // Widget Tabs Quick View - medium
                let tabs = SimpleTab.getSimpleTabs()
                if let uuid = urlScanner.value(query: "uuid"), !tabs.isEmpty, let tab = tabs[uuid] {
                    return .searchURL(url: tab.url, tabId: uuid)
                } else {
                    return .search(url: nil, isPrivate: false)
                }

            case .widgetTabsLargeOpenUrl:
                // Widget Tabs Quick View - large
                let tabs = SimpleTab.getSimpleTabs()
                if let uuid = urlScanner.value(query: "uuid"), !tabs.isEmpty {
                    let tab = tabs[uuid]
                    return .searchURL(url: tab?.url, tabId: uuid)
                } else {
                    return .search(url: nil, isPrivate: false)
                }

            case .fxaSignIn:
                return nil
            }
        } else if urlScanner.isHTTPScheme {
            TelemetryWrapper.gleanRecordEvent(category: .action, method: .open, object: .asDefaultBrowser)
            RatingPromptManager.isBrowserDefault = true
            // Use the last browsing mode the user was in
            return .search(url: url, isPrivate: isPrivate, options: [.focusLocationField])
        } else {
            return nil
        }
    }
