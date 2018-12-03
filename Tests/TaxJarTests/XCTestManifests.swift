import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TaxJarTests.allTests),
        testCase(EnvironmentTests.allTests),
        testCase(AddressTests.allTests),
        testCase(LineItemTests.allCases),
        testCase(CalculateRequestTests.allCases),
        testCase(JurisdictionsTests.allCases),
    ]
}
#endif
