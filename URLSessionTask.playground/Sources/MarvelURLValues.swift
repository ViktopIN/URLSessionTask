import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

public struct MarvelURLValues {

    public let scheme = "https"
    public let host = "gateway.marvel.com"
    public let path = "/v1/public/characters/1009454"
    
    private let publicKey = "6bf7cc2cb014568bc3f57e8181392810"
    private let privateKey = "d5cbbc5c81c6b7f9de975af94dbac807ebf3ff3d"
    
    public let timeStamp = (name: "ts",value: "1")
    public var apiKey:(name: String, value: String) {
        ("apikey", publicKey)
    }
    
    public var hash:(name: String, value: String) {
        let value = MD5(string: "\(timeStamp.value + privateKey + publicKey)")
        return ("hash", value)
    }
    
    private func MD5(string: String) -> String {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
        let hash = digestData.map { String(format: "%02hhx", $0) }.joined()
        return hash
    }
    
    public init() {}
}
