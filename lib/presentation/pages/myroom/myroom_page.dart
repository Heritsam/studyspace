import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/densed_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/study_icons.dart';
import 'viewmodels/myroom_viewmodel.dart';

class MyRoomPage extends ConsumerStatefulWidget {
  const MyRoomPage({super.key});

  @override
  ConsumerState<MyRoomPage> createState() => _MyRoomPageState();
}

class _MyRoomPageState extends ConsumerState<MyRoomPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ref.read(myRoomViewModel).initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(myRoomViewModel);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 120),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ruangan Saya',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ).padding(all: 16),
              const Divider(height: 0, color: grey100Color, thickness: 1),
              TabBar(
                controller: state.tabController,
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                indicatorWeight: 2,
                indicatorColor: ocean500Color,
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: grey500Color,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  const Text('Sedang dipakai').padding(vertical: 16),
                  const Text('Akan datang').padding(vertical: 16),
                  const Text('Riwayat').padding(vertical: 16),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: ref.watch(myRoomViewModel).tabController,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              children: [
                _buildMyRoomCard(
                  onPressed: () {},
                  buttonLabel: 'Pesan makanan atau minuman',
                  icon: StudyIcons.materialSymbolsFastfoodRounded,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              children: [
                _buildMyRoomCard(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Scan kode QR saat check-in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              QrImageView(
                                data: '1234567890',
                                version: QrVersions.auto,
                                size: 230,
                              ),
                              const SizedBox(height: 40),
                              SecondaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: 'Tutup',
                              ).constrained(width: size.width),
                            ],
                          ).padding(all: 20),
                        );
                      },
                    );
                  },
                  buttonLabel: 'Lihat QR Code',
                  icon: Icons.qr_code_rounded,
                ),
              ],
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, color: grey500Color, size: 48),
              SizedBox(height: 12),
              Text(
                'Kamu belum booking ruangan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: grey500Color,
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyRoomCard({
    required String buttonLabel,
    required IconData icon,
    required Function()? onPressed,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: grey100Color,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1694&q=80',
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Karuna Space',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Hangout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Max. 6 orang',
                    style: TextStyle(fontSize: 14, color: grey500Color),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'sisa waktu 48m',
                    style: TextStyle(fontSize: 14, color: grey700Color),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(thickness: 1),
          const SizedBox(height: 12),
          DensedButton(
            onPressed: onPressed,
            label: buttonLabel,
            icon: icon,
          ).constrained(width: double.infinity),
        ],
      ).padding(all: 12),
    ).decorated(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        )
      ],
    );
  }
}
