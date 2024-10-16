// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let network = try? JSONDecoder().decode(Network.self, from: jsonData)

import Foundation

// MARK: - Network
class Network: Codable {
    let response: [NetworkResponse]
    let version: String

    init(response: [NetworkResponse], version: String) {
        self.response = response
        self.version = version
    }
    
    // Método para obtener solo los switches
    func getSwitches() -> [NetworkResponse] {
        return response.filter { $0.type == .typeSwitch }
    }
    
    // Método para obtener solo los routers
    func getRouters() -> [NetworkResponse] {
        return response.filter { $0.type == .router }
    }

}

extension Network {
    static func getNetworkData(token: String) async throws -> Network {
        let url = "http://localhost:58000/api/v1/network-device"
        var request = URLRequest(url: URL(string: url)!)
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HostError.HostsNotFound
        }
        
        let networkData = try JSONDecoder().decode(Network.self, from: data)
        return networkData
    }
}


// MARK: - Response
class NetworkResponse: Codable {
    let collectionStatus: CollectionStatus
    let connectedInterfaceName, connectedNetworkDeviceIPAddress, connectedNetworkDeviceName: [String]
    let errorDescription, globalCredentialID, hostname, id: String
    let interfaceCount: String
    let inventoryStatusDetail: CollectionStatus
    let lastUpdateTime, lastUpdated, macAddress, managementIPAddress: String
    let platformID: String
    let productID: ProductID
    let reachabilityFailureReason: ReachabilityFailureReason
    let reachabilityStatus: ReachabilityStatus
    let serialNumber, softwareVersion: String
    let type: TypeEnum
    let upTime: String
    let ipAddresses: [String]?

    enum CodingKeys: String, CodingKey {
        case collectionStatus, connectedInterfaceName
        case connectedNetworkDeviceIPAddress = "connectedNetworkDeviceIpAddress"
        case connectedNetworkDeviceName, errorDescription
        case globalCredentialID = "globalCredentialId"
        case hostname, id, interfaceCount, inventoryStatusDetail, lastUpdateTime, lastUpdated, macAddress
        case managementIPAddress = "managementIpAddress"
        case platformID = "platformId"
        case productID = "productId"
        case reachabilityFailureReason, reachabilityStatus, serialNumber, softwareVersion, type, upTime, ipAddresses
    }

    init(collectionStatus: CollectionStatus, connectedInterfaceName: [String], connectedNetworkDeviceIPAddress: [String], connectedNetworkDeviceName: [String], errorDescription: String, globalCredentialID: String, hostname: String, id: String, interfaceCount: String, inventoryStatusDetail: CollectionStatus, lastUpdateTime: String, lastUpdated: String, macAddress: String, managementIPAddress: String, platformID: String, productID: ProductID, reachabilityFailureReason: ReachabilityFailureReason, reachabilityStatus: ReachabilityStatus, serialNumber: String, softwareVersion: String, type: TypeEnum, upTime: String, ipAddresses: [String]?) {
        self.collectionStatus = collectionStatus
        self.connectedInterfaceName = connectedInterfaceName
        self.connectedNetworkDeviceIPAddress = connectedNetworkDeviceIPAddress
        self.connectedNetworkDeviceName = connectedNetworkDeviceName
        self.errorDescription = errorDescription
        self.globalCredentialID = globalCredentialID
        self.hostname = hostname
        self.id = id
        self.interfaceCount = interfaceCount
        self.inventoryStatusDetail = inventoryStatusDetail
        self.lastUpdateTime = lastUpdateTime
        self.lastUpdated = lastUpdated
        self.macAddress = macAddress
        self.managementIPAddress = managementIPAddress
        self.platformID = platformID
        self.productID = productID
        self.reachabilityFailureReason = reachabilityFailureReason
        self.reachabilityStatus = reachabilityStatus
        self.serialNumber = serialNumber
        self.softwareVersion = softwareVersion
        self.type = type
        self.upTime = upTime
        self.ipAddresses = ipAddresses
    }
}

enum CollectionStatus: String, Codable {
    case managed = "Managed"
    case unreachable = "Unreachable"
}

enum ProductID: String, Codable {
    case isr4331 = "ISR4331"
    case the296024Tt = "2960-24TT"
}

enum ReachabilityFailureReason: String, Codable {
    case empty = ""
    case notValidated = "NOT_VALIDATED"
}

enum ReachabilityStatus: String, Codable {
    case reachable = "Reachable"
}

enum TypeEnum: String, Codable {
    case router = "Router"
    case typeSwitch = "Switch"
}
