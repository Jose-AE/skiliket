//
//  TemperatureChartSwiftUIView.swift
//  skiliket
//
//  Created by Rosa Palacios on 12/10/24.
//

import SwiftUI
import Charts

struct TemperatureChartSwiftUIView: View {
    
    let temperaturas: [TemperatureInfo]
    
    var body: some View {
        Chart {
            ForEach(temperaturas, id: \.timeStamp) { temp in
                LineMark(
                    x: .value("Día", temp.timeStamp, unit: .day),
                    y: .value("Temperatura", temp.value)
                )
                .foregroundStyle(.purple)
                .interpolationMethod(.catmullRom)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .padding()
    }
}

// Simulación de una estructura para datos de temperatura
struct TemperatureInfo: Identifiable {
    let id = UUID()
    let value: Double
    let timeStamp: Date
}

#Preview {
    TemperatureChartSwiftUIView(
        temperaturas: [
            TemperatureInfo(value: 25, timeStamp: Date()),
            TemperatureInfo(value: 28, timeStamp: Date().addingTimeInterval(86400)),  // +1 día
            TemperatureInfo(value: 30, timeStamp: Date().addingTimeInterval(2 * 86400)),  // +2 días
            TemperatureInfo(value: 27, timeStamp: Date().addingTimeInterval(3 * 86400)),  // +3 días
            TemperatureInfo(value: 29, timeStamp: Date().addingTimeInterval(4 * 86400))   // +4 días
        ]
    )
}
