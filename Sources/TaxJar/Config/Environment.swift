/// The TaxJar environment to use when making requests to the API.
public enum Environment: String, Hashable, CaseIterable, Codable {
    
    /// For production environments.
    case production
    
    /// For testing environments; to make sure you app is working as expected.
    case sandbox
    
    /// The root of the URI used to access the TaxJar API
    /// based on the current environment.
    public var domain: String {
        switch self {
        case .production: return "https://api.taxjar.com"
        case .sandbox: return "https://api.sandbox.taxjar.com"
        }
    }
}
