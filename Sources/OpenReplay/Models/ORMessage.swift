import UIKit

public struct GenericMessage {
    let typeRaw: UInt64
    let type: ORMessageType?
    let timestamp: UInt64
    let body: Data

    init?(data: Data, offset: inout Int) {
        do {
            typeRaw = try data.readPrimary(offset: &offset)
            type = ORMessageType(rawValue: typeRaw)
            timestamp = try data.readPrimary(offset: &offset)
            body = try data.readData(offset: &offset)
        } catch {
            return nil
        }
    }
}

public class ORMessage: NSObject {

    let messageRaw: UInt64
    let message: ORMessageType?
    let timestamp: UInt64

    public init(messageType: ORMessageType) {
        self.messageRaw = messageType.rawValue
        self.message = messageType
        self.timestamp = UInt64(Date().timeIntervalSince1970 * 1000)
    }

    public init?(genericMessage: GenericMessage) {
        self.messageRaw = genericMessage.typeRaw
        self.message = genericMessage.type
        self.timestamp = genericMessage.timestamp
    }

    func contentData() -> Data {
        fatalError("This method should be overridden")
    }
}
