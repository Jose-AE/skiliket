//
//  TemperaturePT.swift
//  skiliket
//
//  Created by Rosa Palacios on 10/10/24.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let temperaturePT = try? JSONDecoder().decode(TemperaturePT.self, from: jsonData)

import Foundation

// MARK: - TemperaturePT
class TemperaturePT: Codable {
    let temperature: Int

    init(temperature: Int) {
        self.temperature = temperature
    }
}
