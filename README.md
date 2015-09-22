# Mockingdrive

Framework for stubbing Hypermedia HTTP requests. Making use of
[Mockingjay](https://github.com/kylef/Mockingjay) and the
[Swift Representor](https://github.com/the-hypermedia-project/representor-swift).

## Usage

Mockingdrive can be used to stub any requests matching a Mockingjay matcher by
a Representor. Here's an example of using the Representor builder pattern:

```swift
stubRepresentor(uri("/questions")) {
  $0.addTransition("next", uri: "/questions?page=2")
  $0.addAttribute("count", value: 22)
}
```

You can also pass in directory a representor structure:

```swift
stub(everything, representor)
```

Full example using the [Hyperdrive](https://github.com/the-hypermedia-project/Hyperdrive) Hypermedia client.

```swift
class QuestionTests : XCTestCase {
  let hyperdrive = Hyperdrive()

  func testQuestions() {
    // Stub /questions using the Representor builder pattern
    stubRepresentor(uri("/questions")) {
      $0.addTransition("next", uri:"/questions?page=2")
      $0.addAttribute("count", value: 22)
    }

    // Use an XCTest expectation, so our tests wait for the request to finish
    let expectation = expectationWithDescription("Mockingdrive")

    // Perform request (using Hyperdrive, you can use other networking libraries)
    hyperdrive.enter("https://fuller.li/") { result in
      switch result {
      case .Success(let representor):
        XCTAssertNotNil(representor.transitions["next"])
        expectation.fulfill()
      case .Failure:
        XCTFail("Unexpected Failure")
      }
    }

    waitForExpectationsWithTimeout(1.0, handler: nil)
  }
}
```

## Installation

[CocoaPods](http://cocoapods.org) is the recommended way to add Mockingdrive
to your project.

```ruby
pod 'Mockingdrive'
```

## License

Mockingdrive is released under the MIT license. See [LICENSE](LICENSE).

