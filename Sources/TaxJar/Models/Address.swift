import Countries
import Vapor

/// An address that can be used for things such as the location an order is coming from or going to.
public struct Address: Content, Equatable {
    
    /// Two-letter ISO country code of the country.
    public var country: Country
    
    /// Postal code (5-Digit ZIP or ZIP+4).
    public var zip: String
    
    /// Two-letter ISO state code.
    public var state: Province
    
    /// City name.
    public var city: String
    
    /// Street address.
    public var street: String
    
    /// Creates a new `Address` instance.
    ///
    /// - Parameters:
    ///   - country: Two-letter ISO country code of the country.
    ///   - zip: Postal code (5-Digit ZIP or ZIP+4).
    ///   - state: Two-letter ISO state code.
    ///   - city: City name.
    ///   - street: Street address.
    public init(country: Country, zip: String, state: Province, city: String, street: String) {
        self.country = country
        self.zip = zip
        self.state = state
        self.city = city
        self.street = street
    }
}
