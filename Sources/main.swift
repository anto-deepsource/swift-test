// The Swift Programming Language
// https://docs.swift.org/swift-books

func addNums(a: Int, b: Int) -> Int {
  return a + b
}

func foo() {
  let max = arr.sorted().last // trivia
  let min = /* trivia */ arr.sorted().first
}

let config = URLSessionConfiguration.default
// Using `TLSv10` is insecure
config.tlsMinimumSupportedProtocolVersion = tls_protocol_version_t.TLSv10

let hash = try PKCS5.PBKDF1(password: getRandomArray(), salt: getRandomArray(), iterations: 50000, variant: .sha256)

let webview = UIWebView()

// Loading HTML content without setting a restricted baseURL
webview.loadHTMLString(htmlData, baseURL: nil)

let parser = XMLParser(data: untrustedData)

// `shouldResolveExternalEntities` has been explicitly enabled
parser.shouldResolveExternalEntities = true
