//
//  TicketResponse.swift
//  Tabla
//
//  Created by Rosa Palacios on 08/10/24.
//
import Foundation

// MARK: - TicketResponse
class TicketResponse: Codable {
    let response: ResponsePTT
    let version: String

    init(response: ResponsePTT, version: String) {
        self.response = response
        self.version = version
    }
}

// MARK: - Response
class ResponsePTT: Codable {
    let idleTimeout: Int
    let serviceTicket: String
    let sessionTimeout: Int

    init(idleTimeout: Int, serviceTicket: String, sessionTimeout: Int) {
        self.idleTimeout = idleTimeout
        self.serviceTicket = serviceTicket
        self.sessionTimeout = sessionTimeout
    }
}

