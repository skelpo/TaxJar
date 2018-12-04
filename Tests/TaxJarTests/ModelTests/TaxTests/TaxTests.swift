import XCTest
@testable import TaxJar

final class TaxTests: XCTestCase {
    let tax: Tax = {
        let jurisdictions = Tax.Jurisdictions(country: .unitedStates, state: nil, county: nil, city: nil)
        let breakdown = Tax.Breakdown(
            taxableAmount: nil, taxCollectable: nil, combinedTaxRate: nil, stateTaxableAmount: nil, stateTaxRate: nil, stateTaxCollectable: nil,
            countyTaxableAmount: 15, countyTaxRate: 0.0025, countyTaxCollectable: 0.04, cityTaxableAmount: nil, cityTaxRate: nil,
            cityTaxCollectable: nil, specialDistrictTaxableAmount: nil, specialTaxRate: nil, specialDistrictTaxCollectable: nil, items: []
        )
        
        return Tax(
            orderTotal: 16.5, shipping: 1.5, taxable: 15, collect: 1.35, rate: 0.09, hasNexus: true, freightTaxable: false,
            source: "destination", jurisdictions: jurisdictions, breakdown: breakdown
        )
    }()
    
    func testInit()throws {
        XCTAssertEqual(self.tax.jurisdictions, .init(country: .unitedStates, state: nil, county: nil, city: nil))
        XCTAssertEqual(self.tax.breakdown, .init(
            taxableAmount: nil, taxCollectable: nil, combinedTaxRate: nil, stateTaxableAmount: nil, stateTaxRate: nil, stateTaxCollectable: nil,
            countyTaxableAmount: 15, countyTaxRate: 0.0025, countyTaxCollectable: 0.04, cityTaxableAmount: nil, cityTaxRate: nil,
            cityTaxCollectable: nil, specialDistrictTaxableAmount: nil, specialTaxRate: nil, specialDistrictTaxCollectable: nil, items: []
        ))
        
        XCTAssertEqual(self.tax.orderTotal, 16.5)
        XCTAssertEqual(self.tax.shipping, 1.5)
        XCTAssertEqual(self.tax.taxable, 15)
        XCTAssertEqual(self.tax.collect, 1.35)
        XCTAssertEqual(self.tax.rate, 0.09)
        XCTAssertEqual(self.tax.hasNexus, true)
        XCTAssertEqual(self.tax.freightTaxable, false)
        XCTAssertEqual(self.tax.source, "destination")
        
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(self.tax), encoding: .utf8)!
        let json =
        "{\"breakdown\":{\"county_tax_collectable\":0.04,\"county_tax_rate\":0.0025,\"line_items\":[],\"county_taxable_amount\":15},\"shipping\":1.5,\"rate\":0.09,\"freight_taxable\":false,\"order_total_amount\":16.5,\"taxable_amount\":15,\"amount_to_collect\":1.35,\"has_nexus\":true,\"tax_source\":\"destination\",\"jurisdictions\":{\"country\":\"US\"}}"
        
        
        var index = 0
        for (g, j) in zip(generated, json) {
            if g != j {
                XCTAssertEqual(g, j)
                break
            }
            index += 1
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "order_total_amount": 16.5,
            "shipping": 1.5,
            "taxable_amount": 15,
            "amount_to_collect": 1.35,
            "rate": 0.09,
            "has_nexus": true,
            "freight_taxable": false,
            "tax_source": "destination",
            "jurisdictions": {
                "country": "US"
            },
            "breakdown": {
                "county_taxable_amount": 15,
                "county_tax_rate": 0.0025,
                "county_tax_collectable": 0.04,
                "line_items": []
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Tax.self, from: json), self.tax)
    }
    
    static var allTests: [(String, (TaxTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



