//
//  NetworkTests.swift
//  ArticlesTaskTests
//
//  Created by kanagasabapathy on 01/02/24.
//

import XCTest
@testable import NewsAPIArticlesTask

final class NetworkTests: XCTestCase {
    // URLSession to invoke the expensive testing
    var session: URLSession!
    // NetworkMonitor helps in testing the Internet Reachability
    let networkMonitor = NetworkMonitor.shared
    // Used the complete URL for testing purpose
    let completeURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7798387c3293416d8928c7663997d6c3"

    // Testing Life Cycle method: setting up
    override func setUpWithError() throws {
        try super.setUpWithError()
        session = URLSession(configuration: .default)
    }
    // Testing Life Cycle method: tearing down
    override func tearDownWithError() throws {
        session = nil
        try super.tearDownWithError()
    }
    // Asynchronous Test: success fast, failure slow
    func testValidAPICallGetsHTTPStatusCode200() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
        let urlString = completeURL
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL  }
        let promise = expectation(description: "Status Code: 200")
        let dataTask = session.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("StatusCode: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5.0)
    }

    // Asynchronous Test: faster fail
    func testAPICallCompletes() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
        let urlString = completeURL
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL  }
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        let dataTask = session.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
final class NetworkErrorTests: XCTestCase {
    func testCustomMessage() {
        XCTAssertEqual(NetworkError.decode.customMessage, "Decode Error")
        XCTAssertEqual(NetworkError.generic.customMessage, "Generic Error")
        XCTAssertEqual(NetworkError.invalidURL.customMessage, "Invalid URL Error")
        XCTAssertEqual(NetworkError.noResponse.customMessage, "No Response")
        XCTAssertEqual(NetworkError.unauthorized.customMessage, "Unauthorized URL")
        XCTAssertEqual(NetworkError.unexpectedStatusCode.customMessage, "Status Code Error")
        XCTAssertEqual(NetworkError.unknown.customMessage, "Unknown Error")
    }
}
