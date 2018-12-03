import Countries
import Vapor

extension Tax {
    
    /// Jurisdiction names for an order.
    public struct Jurisdictions: Content, Encodable {
        
        /// Two-letter ISO country code for given location.
        ///
        /// This value is availible in all countries.
        public var country: Country
        
        /// Postal abbreviated state name for given location.
        ///
        /// This value is availible in the US and Canada.
        public var state: Province?
        
        /// County name for given location.
        ///
        /// This value is availible in the US.
        public var county: String?
        
        /// City name for given location.
        ///
        /// This value is availible in the US, EU, and Canada.
        public var city: String?
        
        
        /// Creates a new `Tax.Jurisdictions` instance.
        ///
        /// - Parameters:
        ///   - country: Two-letter ISO country code for given location.
        ///   - state: Postal abbreviated state name for given location.
        ///   - county: County name for given location.
        ///   - city: City name for given location.
        public init(country: Country, state: Province, county: String, city: String) {
            self.country = country
            self.state = state
            self.county = county
            self.city = city
        }
    }
}
