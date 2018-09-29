//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/25/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
@testable import ToDo
class APIClientTests: XCTestCase {

    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Login_UsesExpectedHost() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(mockURLSession.urlComponents?.host, "awesometodos.com")
    }
    
    func test_Login_UsesExpectedPath() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }

    func test_Login_UsesExptectedQuery() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(mockURLSession.urlComponents?.query, "username=dasdom&password=1234")
    }

}

extension APIClientTests {
    class MockURLSession: SessionProtocol {
        
        var url: URL?
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
