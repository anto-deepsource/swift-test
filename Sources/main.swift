import CryptoSwift

let blockMode = ECB() // Use of `ECB` is not safe
_ = try AES(key: key, blockMode: blockMode, padding: padding)
