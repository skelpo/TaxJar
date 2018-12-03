import Countries
import Vapor

extension Tax {
    
    /// The request body to send to `POST /taxes` to get a tax calculation.
    public struct CalculateRequest: Content, Equatable {
        
        /// The address the order is being shipped from.
        ///
        /// - Note: The properties of this object are coded in-line with the `CalculateRequest` properties.
        public var from: Address
        
        /// The address the order is being shipped to.
        ///
        /// - Note: The properties of this object are coded in-line with the `CalculateRequest` properties.
        public var to: Address
        
        /// Total amount of the order, excluding shipping.
        ///
        /// - Note: Either `amount` or `line_items` parameters are required to perform tax calculations.
        public var amount: Decimal?
        
        /// Total amount of shipping for the order.
        public var shipping: Decimal
        
        /// Unique identifier of the given customer for exemptions.
        public var customer: String?
        
        /// The addresses in the state that the order is being sent to where you have a physical presence that's
        /// significant enough for you to be required to comply with that state's sales tax laws.
        ///
        /// See [How do I know where I have nexus?](https://support.taxjar.com/article/115-how-do-i-know-where-i-have-nexus).
        public var nexus: [Address]?
        
        /// The items in the order.
        public var items: [LineItem]?
        
        public init(from: Address, to: Address, amount: Decimal?, shipping: Decimal, customer: String?, nexus: [Address]?, items: [LineItem]?) {
            self.from = from
            self.to = to
            self.amount = amount
            self.shipping = shipping
            self.customer = customer
            self.nexus = nexus
            self.items = items
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let from = try Address(
                country: container.decode(Country.self, forKey: .fromCountry),
                zip: container.decodeIfPresent(String.self, forKey: .fromZip),
                state: container.decodeIfPresent(Province.self, forKey: .fromState),
                city: container.decodeIfPresent(String.self, forKey: .fromCity),
                street: container.decodeIfPresent(String.self, forKey: .fromStreet)
            )
            let to = try Address(
                country: container.decode(Country.self, forKey: .toCountry),
                zip: container.decodeIfPresent(String.self, forKey: .toZip),
                state: container.decodeIfPresent(Province.self, forKey: .toState),
                city: container.decodeIfPresent(String.self, forKey: .toCity),
                street: container.decodeIfPresent(String.self, forKey: .toStreet)
            )
            
            try self.init(
                from: from,
                to: to,
                amount: container.decodeIfPresent(Decimal.self, forKey: .amount),
                shipping: container.decode(Decimal.self, forKey: .shipping),
                customer: container.decodeIfPresent(String.self, forKey: .customer),
                nexus: container.decodeIfPresent([Address].self, forKey: .nexus),
                items: container.decodeIfPresent([LineItem].self, forKey: .items)
            )
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encodeIfPresent(self.amount, forKey: .amount)
            try container.encode(self.shipping, forKey: .shipping)
            try container.encodeIfPresent(self.customer, forKey: .customer)
            try container.encode(self.nexus ?? [], forKey: .nexus)
            try container.encode(self.items ?? [], forKey: .items)
            
            try container.encode(self.from.country, forKey: .fromCountry)
            try container.encodeIfPresent(self.from.zip, forKey: .fromZip)
            try container.encodeIfPresent(self.from.state, forKey: .fromState)
            try container.encodeIfPresent(self.from.city, forKey: .fromCity)
            try container.encodeIfPresent(self.from.street, forKey: .fromStreet)
            
            try container.encode(self.to.country, forKey: .toCountry)
            try container.encodeIfPresent(self.to.zip, forKey: .toZip)
            try container.encodeIfPresent(self.to.state, forKey: .toState)
            try container.encodeIfPresent(self.to.city, forKey: .toCity)
            try container.encodeIfPresent(self.to.street, forKey: .toStreet)

        }
        
        enum CodingKeys: String, CodingKey {
            case amount, shipping
            case customer = "customer_id"
            case nexus = "nexus_addresses"
            case items = "line_items"
            
            case fromCountry = "from_country"
            case fromZip = "from_zip"
            case fromState = "from_state"
            case fromCity = "from_city"
            case fromStreet = "from_street"
            
            case toCountry = "to_country"
            case toZip = "to_zip"
            case toState = "to_state"
            case toCity = "to_city"
            case toStreet = "to_street"
        }
    }
}
