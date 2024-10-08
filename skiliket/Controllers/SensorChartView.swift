import SwiftUI
import Charts

struct SensorChartView: View {
    var sensorData: [Double]
    var sensorName: String

    var body: some View {
        VStack {
            Text("\(sensorName) Data")
                .font(.headline)

            Chart {
                ForEach(sensorData.indices, id: \.self) { index in
                    LineMark(
                        x: .value("Day", index),
                        y: .value("Value", sensorData[index])
                    )
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) {
                    AxisGridLine()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                }
            }
            .padding()
        }
    }
}
