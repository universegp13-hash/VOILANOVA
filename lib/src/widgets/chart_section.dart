import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/chart_data.dart';

class RevenueChart extends StatelessWidget {
  final List<ChartData> data;

  const RevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value / 1000);
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Revenue Over Time',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            SizedBox(
              height: 190,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 38)),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < data.length) {
                                return Text(data[value.toInt()].label,
                                    style: const TextStyle(fontSize: 12));
                              }
                              return const Text('');
                            })),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      color: Theme.of(context).colorScheme.primary,
                      isCurved: true,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarPerformanceChart extends StatelessWidget {
  final List<ChartData> data;

  const BarPerformanceChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Top Performing Products',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            ...data.map((chartData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(chartData.label)),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 7,
                      child: Stack(
                        children: [
                          Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8))),
                          FractionallySizedBox(
                            widthFactor:
                                (chartData.value / 100).clamp(0.0, 1.0),
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(chartData.value.toStringAsFixed(0)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
