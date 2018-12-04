import Vapor
import XCTest
@testable import TaxJar

final class SaleTaxTests: XCTestCase {
    var app: Application!
    
    override func setUp() {
        super.setUp()
        
        guard let key = Environment.get("TAXJAR_KEY") else {
            fatalError("Please create an environment variable `TAXJAR_KEY` with you TaxJar API key.")
        }
        var services = Services.default()
        try! services.register(TaxJarProvider(key: key))
        
        self.app = try! Application.testable(services: services)
    }
    
    func testTax()throws {
        let from = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
        let to = Address(country: .unitedStates, zip: "90002", state: .ca, city: "Los Angeles", street: "1335 E 103rd St")
        let nexus = [Address(id: "Main Location", country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")]
        let items = [LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)]
        let request = Tax.CalculateRequest(from: from, to: to, amount: 15, shipping: 1.5, customer: "31415", nexus: nexus, items: items)
        
        let tax = try self.app.make(SalesTax.self).tax(for: request).wait()
        
        print(tax)
    }
    
    static var allTests: [(String, (SaleTaxTests) -> ()throws -> ())] = [
        ("testTax", testTax)
    ]
}



