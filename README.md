# TaxJar

A [Vapor](https://vapor.codes/) client for the [TaxJar API](https://developers.taxjar.com/api/reference/).

## Setup


### Create a TaxJar Account

You will want to [create a TaxJar account](https://app.taxjar.com/sign_up) if you don't have one already. You will then need to generate an API token, which you will then be able to access from [your dashboard](https://app.taxjar.com/account#api-access).

### Install Package

Add the package instance to your manifest's `dependencies` array with the [latest version](https://github.com/skelpo/TaxJar/releases/latest):


```swift
.package(url: "https://github.com/skelpo/TaxJar.git", from: "0.1.0")
```

And run `swift package update`.

### Add the Provider

To use the TaxJar client, you will need to add the `TaxJarProvider` to your app's services. The initializer takes in your API key. It is recommended that you don't hard code the value into your app. Instead you should assign it to an environment variable and get it when your app boots.

```bash
export TAXJAR_KEY=API-KEY
```
```swift
guard let key = Environment.get("TAXJAR_KEY") else {
    throw Abort(.internalServerError, reason: "Missing env var `TAXJAR_KEY `")
}

try services.register(TaxJarProvider(key: key))
```

## API

Right now, only the [`POST /taxes`](https://developers.taxjar.com/api/reference/#taxes) endpoint is supported. You can access it by getting the `SalesTax` instance from a container and calling `.tax(for:)` with the information to calculate the tax:

```swift
let from = Address(country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")
let to = Address(country: .unitedStates, zip: "90002", state: .ca, city: "Los Angeles", street: "1335 E 103rd St")
let nexus = [Address(id: "Main Location", country: .unitedStates, zip: "92093", state: .ca, city: "La Jolla", street: "9500 Gilman Drive")]
let items = [LineItem(id: "1", quantity: 1, taxCode: "20010", price: 15, discount: 0)]
let request = Tax.CalculateRequest(from: from, to: to, amount: 15, shipping: 1.5, customer: "31415", nexus: nexus, items: items)

let tax = try self.app.make(SalesTax.self).tax(for: request)
```




