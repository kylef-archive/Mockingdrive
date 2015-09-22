import XCTest
import Mockingjay
import Representor


let representorSerializers = [
  "application/vnd.siren+json": serializeSiren,
  "application/hal+json": serializeHAL,
  "application/vnd.hal+json": serializeHAL,
]


/// Extensions to XCTest to provide stubbing Hypermedia responses
extension XCTest {
  /// Stub any requests matching the matcher with the given Representor
  public func stub(matcher:Matcher, contentType:String = "application/hal+json", representor:Representor<HTTPTransition>) -> Stub {
    return stub(matcher) { request in
      let acceptHeader = request.valueForHTTPHeaderField("Accept") ?? contentType
      let contentTypes = acceptHeader.componentsSeparatedByString(",")
                                     .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) }
                                     .filter { representorSerializers.keys.contains($0) }

      if let contentType = contentTypes.first, serializer = representorSerializers[contentType] {
        let representation = serializer(representor)
        return json(representation, headers: ["Content-Type": contentType])(request: request)
      }

      let errorDescription = "Unknown or unsupported content types (Accept: \(acceptHeader))"
      return .Failure(NSError(domain: "Mockingdrive", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription]))
    }
  }

  /// Stub any requests matching the matcher with the given Representor builder
  public func stubRepresentor(matcher:Matcher, contentType:String = "application/hal+json", closure:(RepresentorBuilder<HTTPTransition> -> ())) -> Stub {
    return stub(matcher, contentType: contentType, representor: Representor(closure))
  }
}
