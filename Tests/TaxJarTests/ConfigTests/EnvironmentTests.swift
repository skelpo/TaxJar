import XCTest
@testable import TaxJar

final class EnvironmentTests: XCTestCase {
    private struct API: Codable {
        let env: Environment
    }
    
    func testRawValues()throws {
        XCTAssertEqual(Environment.production.rawValue, "production")
        XCTAssertEqual(Environment.sandbox.rawValue, "sandbox")
    }
    
    func testAllCases()throws {
        XCTAssertEqual(Environment.allCases.count, 2)
        XCTAssertEqual(Environment.allCases, [.production, .sandbox])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let json = try String(data: encoder.encode(API(env: .production)), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"env\":\"production\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "env": "sandbox"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(API.self, from: json).env, .sandbox)
    }
    
    static var allTests: [(String, (EnvironmentTests) -> ()throws -> ())] = [
        ("testRawValues", testRawValues),
        ("testAllCases", testAllCases),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
