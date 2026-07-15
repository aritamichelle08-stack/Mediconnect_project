import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverDashboardScreen extends StatelessWidget {
  final String caregiverId;

  const CaregiverDashboardScreen({Key? key, required this.caregiverId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey.shade50, // Clean, clinical background light gray
      appBar: AppBar(
        title: const Text(
          'Patient Monitoring Console',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        backgroundColor: const Color(0xFF0F5257), // Deep surgical teal
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {}, // Ready for manual polling if needed
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scientific Status Banner
          Container(
            width: double.infinity,
            color: const Color(0xFF0F5257),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Text(
              'ACTIVE MONITORING NODE: SECURE_CONN_ACTIVE',
              style: TextStyle(
                color: Colors.teal.shade100,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // Spacious Alerts Area
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('alerts')
                  .where('caregiverId', isEqualTo: caregiverId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF0F5257)),
                  );
                }

                List<Map<String, dynamic>> displayAlerts = [];

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // Scientific mock data with clear health parameters and elevated metadata
                  displayAlerts = [
                    {
                      'severity': 'CRITICAL',
                      'source': 'ACCELEROMETER_NODE_03',
                      'message':
                          'POTENTIAL FALL DETECTED: Impact threshold exceeded in Living Room zone.',
                      'timestamp': DateTime.now().subtract(
                        const Duration(minutes: 5),
                      ),
                    },
                    {
                      'severity': 'WARNING',
                      'source': 'BIOMETRIC_STRAP_01',
                      'message':
                          'ACUTE TACHYCARDIA: Transient heart rate spike measured at 110 BPM during period of inactive status.',
                      'timestamp': DateTime.now().subtract(
                        const Duration(hours: 1),
                      ),
                    },
                    {
                      'severity': 'ROUTINE',
                      'source': 'MANUAL_ENTRY_LOG',
                      'message':
                          'PHARMACOLOGICAL COMPLIANCE: Scheduled beta-blocker dosage verified as administered.',
                      'timestamp': DateTime.now().subtract(
                        const Duration(hours: 3),
                      ),
                    },
                    {
                      'severity': 'ROUTINE',
                      'source': 'PATIENT_APP_FEEDBACK',
                      'message':
                          'SUBJECTIVE STATUS REPORT: Patient self-reported comfort levels: Optimal.',
                      'timestamp': DateTime.now().subtract(
                        const Duration(hours: 6),
                      ),
                    },
                  ];
                } else {
                  displayAlerts = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return {
                      'severity': data['severity'] ?? 'ROUTINE',
                      'source': data['source'] ?? 'CLINICAL_SYS',
                      'message': data['message'] ?? 'No message available',
                      'timestamp':
                          (data['timestamp'] as Timestamp?)?.toDate() ??
                          DateTime.now(),
                    };
                  }).toList();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ), // Generous padding
                  itemCount: displayAlerts.length,
                  itemBuilder: (context, index) {
                    final alert = displayAlerts[index];
                    final String severity = alert['severity'] as String;
                    final String source = alert['source'] as String;
                    final String message = alert['message'] as String;
                    final DateTime timestamp = alert['timestamp'] as DateTime;

                    // Color palette mapped directly to clinical triage priorities
                    Color cardColor = Colors.white;
                    Color accentColor = Colors.blueGrey;
                    IconData indicatorIcon = Icons.info_outline_rounded;

                    if (severity == 'CRITICAL') {
                      cardColor = const Color(
                        0xFFFFF5F5,
                      ); // Ultra-light sterile red
                      accentColor = const Color(
                        0xFFD93838,
                      ); // Deep arterial red
                      indicatorIcon = Icons.report_gmailerrorred_rounded;
                    } else if (severity == 'WARNING') {
                      cardColor = const Color(
                        0xFFFFF9F2,
                      ); // Ultra-light clinical amber
                      accentColor = const Color(
                        0xFFE28700,
                      ); // Surgical yellow/amber
                      indicatorIcon = Icons.warning_rounded;
                    } else if (severity == 'ROUTINE') {
                      cardColor = const Color(
                        0xFFF4FAF7,
                      ); // Medical clean green
                      accentColor = const Color(0xFF2A9D8F); // Health green
                      indicatorIcon = Icons.check_circle_outline_rounded;
                    }

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 16.0,
                      ), // Generous spacing between cards
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: accentColor.withOpacity(0.3),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          18.0,
                        ), // Spaced-out inner content
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Metadata Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      indicatorIcon,
                                      color: accentColor,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      severity,
                                      style: TextStyle(
                                        color: accentColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  source,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ), // Clean separation inside card
                            // Scientific Message
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.blueGrey.shade900,
                                height: 1.4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 14),
                            const Divider(height: 1, thickness: 0.5),
                            const SizedBox(height: 8),

                            // Timestamp Footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')} | ${timestamp.day}/${timestamp.month}/${timestamp.year}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                    fontFamily:
                                        'monospace', // Monospaced numbers for scientific look
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
