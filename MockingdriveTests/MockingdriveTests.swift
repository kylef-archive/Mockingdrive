import XCTest
import Hyperdrive
import Mockingjay
import Mockingdrive
import Representor


class MockingdriveTests: XCTestCase {
  func testStubHALRepresentor() {
    stub(uri("https://fuller.li/"), representor: Representor { builder in
      builder.addAttribute("name", value: "Kyle Fuller")
    })

    let expectation = expectationWithDescription("HAL Request")
    let hyperdrive = Hyperdrive(preferredContentTypes: ["application/hal+json"])

    hyperdrive.enter("https://fuller.li/") { result in
      switch result {
      case .Success(let representor):
        XCTAssertEqual(representor.attributes as! [String:String], ["name": "Kyle Fuller"])
        expectation.fulfill()
      case .Failure(let error):
        XCTFail("Unexpected failure: \(error)")
      }
    }

    waitForExpectationsWithTimeout(1.0, handler: nil)
  }

  func testStubSirenRepresentor() {
    stub(uri("https://fuller.li/"), representor: Representor { builder in
      builder.addAttribute("name", value: "Kyle Fuller")
    })

    let expectation = expectationWithDescription("Siren Request")
    let hyperdrive = Hyperdrive(preferredContentTypes: ["application/vnd.siren+json"])

    hyperdrive.enter("https://fuller.li/") { result in
      switch result {
      case .Success(let representor):
        XCTAssertEqual(representor.attributes as! [String:String], ["name": "Kyle Fuller"])
        expectation.fulfill()
      case .Failure(let error):
        XCTFail("Unexpected failure: \(error)")
      }
    }

    waitForExpectationsWithTimeout(1.0, handler: nil)
  }

  func testStubRepresentor() {
    stubRepresentor(uri("https://fuller.li/")) { builder in
      builder.addAttribute("name", value: "Kyle Fuller")
    }

    let expectation = expectationWithDescription("Representor Request")
    let hyperdrive = Hyperdrive(preferredContentTypes: ["application/hal+json"])

    hyperdrive.enter("https://fuller.li/") { result in
      switch result {
      case .Success(let representor):
        XCTAssertEqual(representor.attributes as! [String:String], ["name": "Kyle Fuller"])
        expectation.fulfill()
      case .Failure(let error):
        XCTFail("Unexpected failure: \(error)")
      }
    }

    waitForExpectationsWithTimeout(1.0, handler: nil)
  }
}
