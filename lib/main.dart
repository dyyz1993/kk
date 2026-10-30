import 'package:flutter/material.dart';

void main() {
  final isEditor = Uri.base.toString().contains('editor');
  runApp(DrelApp(initialRoute: isEditor ? '/editor' : '/'));
}

class DrelApp extends StatelessWidget {
  final String initialRoute;
  const DrelApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drel · 我的电脑',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0A0E),
        fontFamilyFallback: const ['Noto Sans SC', 'sans-serif'],
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (_) => const HomeDeviceListPage(),
        '/editor': (_) => const KeyEditorPage(),
      },
    );
  }
}

const _white = Colors.white;

class _Device {
  final String name, hint;
  final List<Color> gradient;
  const _Device(this.name, this.hint, this.gradient);
}

class HomeDeviceListPage extends StatelessWidget {
  const HomeDeviceListPage({super.key});

  static const _devices = [
    _Device('示例 Mac · macOS', '点击电脑进入演示',
        [Color(0xFF243F65), Color(0xFF292D50)]),
    _Device('云端电竞服务器（上海机房）', '点击电脑进入演示',
        [Color(0xFF3A2F63), Color(0xFF292D50)]),
    _Device('办公室主力机（RTX 4090）', '离线 · 上次在线 2 小时前',
        [Color(0xFF243F65), Color(0xFF1C1F38)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearch(),
                    const SizedBox(height: 20),
                    ..._devices.map(_buildDeviceCard),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Home header：标题 18px Medium + 数量 + 演示模式提示 + 添加电脑按钮
  Widget _buildHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('我的电脑',
                        style: TextStyle(
                            color: _white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 28 / 18)),
                    SizedBox(width: 4),
                    Opacity(
                      opacity: 0.4,
                      child: Text('6',
                          style: TextStyle(
                              color: _white,
                              fontSize: 14,
                              height: 20 / 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Opacity(
                  opacity: 0.45,
                  child: Text('演示模式 · 设备状态为示例',
                      style: TextStyle(
                          color: _white, fontSize: 12, height: 16 / 12)),
                ),
              ],
            ),
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Row(
                children: [
                  Opacity(
                    opacity: 0.75,
                    child: Icon(Icons.add, size: 16, color: _white),
                  ),
                  SizedBox(width: 6),
                  Opacity(
                    opacity: 0.75,
                    child: Text('添加电脑',
                        style: TextStyle(color: _white, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // 搜索框：白 5% 底、圆角 12、高 44
  Widget _buildSearch() => Container(
        height: 44,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: _white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 16, color: _white.withOpacity(0.4)),
            const SizedBox(width: 12),
            Text('搜索电脑名称或 IP',
                style: TextStyle(
                    color: _white.withOpacity(0.5), fontSize: 14)),
          ],
        ),
      );

  // 设备卡：370 宽，渐变插画区 208 高圆角 16 + 名称/状态 + 操作行
  Widget _buildDeviceCard(_Device d) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 插画区
            Container(
              height: 208,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: d.gradient,
                  transform: const GradientRotation(150.64 * 3.14159 / 180),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 装饰蓝圆
                  Positioned(
                    right: -36,
                    top: -40,
                    child: Container(
                      width: 176,
                      height: 176,
                      decoration: BoxDecoration(
                        color: const Color(0xFF93C5FD).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(88),
                      ),
                    ),
                  ),
                  // CSS 桌面窗口插画
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 35, bottom: 46),
                      width: 274,
                      height: 127,
                      decoration: BoxDecoration(
                        color: const Color(0xFF101827).withOpacity(0.75),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 15,
                              offset: Offset(0, 10),
                              color: Color(0x1A000000)),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 标题栏 + 三个点
                          Container(
                            height: 23,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: _white.withOpacity(0.05),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                            child: Row(
                              children: [
                                _dot(4, _white.withOpacity(0.3)),
                                const SizedBox(width: 4),
                                _dot(4, _white.withOpacity(0.2)),
                                const SizedBox(width: 4),
                                _dot(4, _white.withOpacity(0.2)),
                              ],
                            ),
                          ),
                          // 侧栏 + 内容行
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 22,
                                  top: 18,
                                  child: Container(
                                    width: 66,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFBFDBFE)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 107,
                                  top: 21,
                                  child: _line(118, 8, 0.2),
                                ),
                                Positioned(
                                  left: 107,
                                  top: 40,
                                  child: _line(88, 6, 0.1),
                                ),
                                Positioned(
                                  left: 107,
                                  top: 58,
                                  child: _line(104, 6, 0.1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Dock
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 17,
                    child: Center(
                      child: Container(
                        height: 17,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: _white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _dot(9, const Color(0xFFBFDBFE).withOpacity(0.4)),
                            const SizedBox(width: 4),
                            _dot(9, _white.withOpacity(0.3)),
                            const SizedBox(width: 4),
                            _dot(9, const Color(0xFFDDD6FE).withOpacity(0.4)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 示意画面徽章
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('示意画面',
                          style: TextStyle(
                              color: _white.withOpacity(0.8),
                              fontSize: 10,
                              height: 15 / 10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 名称 + 在线状态
            Row(
              children: [
                Expanded(
                  child: Text(d.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: _white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 20 / 14)),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6EE7B7),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                const Text('在线',
                    style: TextStyle(
                        color: Color(0xFF6EE7B7),
                        fontSize: 12,
                        height: 16 / 12)),
              ],
            ),
            const SizedBox(height: 4),
            // 提示 + 管理
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: 0.4,
                      child: Text(d.hint,
                          style: const TextStyle(
                              color: _white,
                              fontSize: 12,
                              height: 19.5 / 12)),
                    ),
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tune,
                            size: 13, color: _white.withOpacity(0.55)),
                        const SizedBox(width: 4),
                        Text('管理',
                            style: TextStyle(
                                color: _white.withOpacity(0.55),
                                fontSize: 12,
                                height: 16 / 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      );

  Widget _dot(double size, Color c) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  Widget _line(double w, double h, double opacity) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: _white.withOpacity(opacity),
          borderRadius: BorderRadius.circular(4),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════
// 键位编辑器（node 107:13718 · 04 替换功能夹槽位并决定保留）
// 结构：编辑目标条 → 工具栏 → 属性面板(可收起) → 键位画布 → 缩放控件
// ═══════════════════════════════════════════════════════════════

const _accent = Color(0xFF0A84FF);
const _textGray = Color(0xFF737373);
const _toolbarBg = Color(0xFF1C1C1F);
const _panelBg = Color(0xFF242428);

class KeyEditorPage extends StatefulWidget {
  const KeyEditorPage({super.key});
  @override
  State<KeyEditorPage> createState() => _KeyEditorPageState();
}

class _KeyEditorPageState extends State<KeyEditorPage> {
  bool _panelOpen = true;
  double _size = 0.85;
  double _opacity = 0.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14181F),
      body: Stack(
        children: [
          // ── 画布：窗口流背景（渐变模拟）──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E2A38), Color(0xFF16202B), Color(0xFF101720)],
                ),
              ),
            ),
          ),
          // 侧栏占位
          Positioned(left: 20, top: 90, bottom: 120, width: 54,
            child: Container(decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(8)))),
          // 内容占位行
          Positioned(left: 96, top: 104,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('交互展示内容 · 非窥窗口画面',
                    style: TextStyle(color: _white.withOpacity(0.35), fontSize: 12)),
                const SizedBox(height: 16),
                _line(200, 8, 0.08), const SizedBox(height: 12),
                _line(160, 6, 0.06), const SizedBox(height: 12),
                _line(180, 6, 0.06),
              ])),
          // HUD 状态条
          Positioned(left: 39, top: 30,
            child: Container(width: 324, height: 27,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6)))),
          // ── 键位（绝对定位，坐标来自 get_metadata）──
          ..._buildKeys(),
          // 选中框（80×80，列表键位置）
          Positioned(
            left: 150.9, top: 621.5,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: _accent, width: 1.5),
                borderRadius: BorderRadius.circular(16)),
              child: const Stack(children: [
                Positioned(left: -3, top: -3, child: _Handle()),
                Positioned(right: -3, top: -3, child: _Handle()),
                Positioned(left: -3, bottom: -3, child: _Handle()),
                Positioned(right: -3, bottom: -3, child: _Handle()),
              ]),
            ),
          ),
          // ── 顶部：编辑目标条 + 工具栏 + 属性面板 ──
          Positioned(
            left: 0, right: 0, top: 0,
            child: Column(
              children: [
                _buildTargetBar(),
                _buildToolbar(),
                if (_panelOpen) _buildPropertyPanel(),
                if (_panelOpen)
                  GestureDetector(
                    onTap: () => setState(() => _panelOpen = false),
                    child: _collapsePill(),
                  )
                else
                  GestureDetector(
                    onTap: () => setState(() => _panelOpen = true),
                    child: _collapsePill(),
                  ),
              ],
            ),
          ),
          // ── 底部：缩放控件 + 模拟窗口提示 + home indicator ──
          Positioned(
            left: 0, right: 0, bottom: 12,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _zoomControls(),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.open_in_full, size: 14, color: _white),
                        SizedBox(height: 6),
                        Text('模拟窗口 · 同一台 Mac',
                            style: TextStyle(color: _textGray, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(width: 128, height: 4,
                    decoration: BoxDecoration(
                      color: _white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _collapsePill() => Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xCC101820),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(_panelOpen ? Icons.expand_less : Icons.expand_more,
              size: 14, color: _white),
          const SizedBox(width: 4),
          Text(_panelOpen ? '收起' : '展开',
              style: const TextStyle(color: _white, fontSize: 12)),
        ]),
      );

  // 编辑目标条
  Widget _buildTargetBar() => Container(
        height: 24,
        color: const Color(0xFF0E1013),
        padding: const EdgeInsets.only(left: 12, top: 4),
        alignment: Alignment.centerLeft,
        child: const Text('编辑目标：VSCodium · 示例项目 · 单窗口布局',
            style: TextStyle(color: _textGray, fontSize: 12)),
      );

  // 工具栏 44px：默认方案胶囊 + 单键/组合键 + 取消/完成
  Widget _buildToolbar() => Container(
        height: 44,
        color: _toolbarBg,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF252529),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _white.withOpacity(0.1)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.folder_copy_rounded, size: 12, color: _white),
                  SizedBox(width: 4),
                  Text('默认方案',
                      style: TextStyle(
                          color: _white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 12, color: _white),
                ],
              ),
            ),
            const Spacer(),
            _pill('+ 单键', filled: true),
            const SizedBox(width: 6),
            _pill('+ 组合键', filled: true),
            const Spacer(),
            const Text('取消',
                style: TextStyle(color: _white, fontSize: 13)),
            const SizedBox(width: 10),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(children: [
                Icon(Icons.play_arrow_rounded, size: 14, color: _white),
                SizedBox(width: 2),
                Text('完成',
                    style: TextStyle(
                        color: _white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ]),
            ),
          ],
        ),
      );

  Widget _pill(String text, {required bool filled}) => Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: filled ? _accent.withOpacity(0.9) : _white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(color: _white, fontSize: 12)),
        ),
      );

  // 属性面板：选中键 W · 前进(W)
  Widget _buildPropertyPanel() => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: _panelBg,
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16)),
          boxShadow: const [
            BoxShadow(blurRadius: 12, color: Color(0x66000000))
          ],
        ),
        child: Column(
          children: [
            // 行1：键图标 + 单键 + 名称 + 操作
            Row(
              children: [
                Container(
                  width: 30, height: 30,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3A3A3E), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const Text('W',
                      style: TextStyle(
                          color: _white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(children: [
                    Container(width: 6, height: 6,
                      decoration: const BoxDecoration(
                          color: _accent, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    const Text('单键',
                        style: TextStyle(color: _accent, fontSize: 11)),
                  ]),
                ),
                const SizedBox(width: 8),
                const Text('前进（W）',
                    style: TextStyle(
                        color: _white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                _opIcon(Icons.edit_outlined),
                const SizedBox(width: 6),
                _opIcon(Icons.visibility_outlined),
                const SizedBox(width: 6),
                _opIcon(Icons.grid_view_rounded),
                const SizedBox(width: 6),
                _opIcon(Icons.folder_copy_outlined),
                const SizedBox(width: 6),
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete_outline,
                      size: 16, color: Color(0xFFEF4444)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 行2：大小 / 不透明度 滑杆
            Row(
              children: [
                const Text('大小',
                    style: TextStyle(
                        color: _white, fontSize: 12)),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 7),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 12),
                    ),
                    child: Slider(
                      value: _size,
                      activeColor: _accent,
                      inactiveColor: _white.withOpacity(0.15),
                      onChanged: (v) => setState(() => _size = v),
                    ),
                  ),
                ),
                SizedBox(
                  width: 34,
                  child: Text('${(_size * 100).round()}%',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: _accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(width: 12),
                const Text('不透明度',
                    style: TextStyle(color: _white, fontSize: 12)),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 7),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 12),
                    ),
                    child: Slider(
                      value: _opacity,
                      activeColor: _accent,
                      inactiveColor: _white.withOpacity(0.15),
                      onChanged: (v) => setState(() => _opacity = v),
                    ),
                  ),
                ),
                SizedBox(
                  width: 34,
                  child: Text('${(_opacity * 100).round()}%',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: _accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // 行3：按下后 单击/连点/按住 + 形状
            Row(
              children: [
                const Text('按下后',
                    style: TextStyle(color: _white, fontSize: 12)),
                const SizedBox(width: 8),
                _seg('单击', selected: true),
                _seg('连点'),
                _seg('按住'),
                const Spacer(),
                const Text('形状',
                    style: TextStyle(color: _white, fontSize: 12)),
                const SizedBox(width: 8),
                _shapeIcon(Icons.circle, selected: true),
                const SizedBox(width: 6),
                _shapeIcon(Icons.crop_square, selected: false),
                const SizedBox(width: 6),
                _shapeIcon(Icons.radio_button_unchecked, selected: false),
              ],
            ),
            const SizedBox(height: 12),
            // 行4：语音 / 提示 / 振动 开关
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _toggle('语音'),
                _toggle('提示'),
                _toggle('振动'),
                const SizedBox(width: 40),
              ],
            ),
          ],
        ),
      );

  Widget _opIcon(IconData i) => Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: _white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(i, size: 16, color: _white.withOpacity(0.6)),
      );

  Widget _seg(String t, {bool selected = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? _accent : _white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(t,
            style: TextStyle(
                color: selected ? _white : _white.withOpacity(0.6),
                fontSize: 12)),
      );

  Widget _shapeIcon(IconData i, {required bool selected}) => Icon(i,
      size: 18, color: selected ? _accent : _white.withOpacity(0.5));

  Widget _toggle(String label) => Row(children: [
        Text(label,
            style: TextStyle(
                color: _white.withOpacity(0.8), fontSize: 12)),
        const SizedBox(width: 8),
        Container(
          width: 32, height: 18,
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 2),
              child: CircleAvatar(
                  radius: 7, backgroundColor: _white),
            ),
          ),
        ),
      ]);

  Widget _zoomControls() => Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xCC1C1C1F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('−',
                  style: TextStyle(
                      color: _white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            Text('100%',
                style: TextStyle(color: _white, fontSize: 12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('+',
                  style: TextStyle(
                      color: _white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

  // ── 键位集合（坐标取自 get_metadata 的实例位置）──
  List<Widget> _buildKeys() => [
        _key(31.8, 561.1, 'A', '向左 (A)', 49),
        _key(67.96, 534.9, 'W', '前进 (W)', 49),
        _key(67.96, 561.1, 'S', '后退 (S)', 49),
        _key(108.2, 561.1, 'D', '向右 (D)', 49),
        _key(212.7, 561.1, 'Q', '一键粮 (Q)', 49),
        _key(256.9, 534.9, 'E', '二技能 (E)', 49),
        _key(302.1, 278.4, 'R', '终极技能…', 55),
        _key(214.2, 667.5, 'F', '技能 (F)', 46),
        _key(306.2, 645.5, 'Space', '跳跃/确认', 55),
        _key(338.8, 169.3, '⚡', '宏', 46),
        _key(163, 228 + 8, '收起', '', 76, pill: true, h: 28),
        _key(272.5, 198.2, '◎', '滚轮', 58),
        _key(158.9, 629.5, '⊞', '功能夹', 64),
        _key(339.8, 30.4, '⚙', '', 44),
      ];

  Widget _key(double x, double y, String label, String sub, double size,
          {bool pill = false, double? h}) =>
      Positioned(
        left: x, top: y,
        child: pill
            ? Container(
                width: size, height: h ?? 28,
                decoration: BoxDecoration(
                  color: const Color(0xCC101820),
                  borderRadius: BorderRadius.circular(14)),
                alignment: Alignment.center,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.expand_less, size: 12, color: _white),
                  Text(label,
                      style: const TextStyle(
                          color: _white, fontSize: 11)),
                ]),
              )
            : Container(
                width: size, height: size,
                decoration: BoxDecoration(
                  color: const Color(0xCC101820),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _white.withOpacity(0.12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label,
                        style: TextStyle(
                            color: _white,
                            fontSize: size > 50 ? 15 : 13,
                            fontWeight: FontWeight.bold)),
                    if (sub.isNotEmpty)
                      Text(sub,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: _white.withOpacity(0.55),
                              fontSize: 7)),
                  ],
                ),
              ),
      );

  Widget _line(double w, double h, double o) => Container(
        width: w, height: h,
        decoration: BoxDecoration(
          color: _white.withOpacity(o),
          borderRadius: BorderRadius.circular(4)),
      );
}

class _Handle extends StatelessWidget {
  const _Handle();
  @override
  Widget build(BuildContext context) => Container(
        width: 7, height: 7,
        decoration: BoxDecoration(
          color: _white,
          border: Border.all(color: _accent, width: 1),
          borderRadius: BorderRadius.circular(1.5)),
      );
}
