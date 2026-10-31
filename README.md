# RemoteDesk

RemoteDesk · 手机远程连接并控制 Mac 的 Flutter 应用（根据 Figma 设计稿「Drel · Tongbuview v20」还原）。

## 功能
- 设备列表页：搜索、设备卡片（在线状态、示意画面）
- 键位编辑器：工具栏、属性面板（大小/不透明度/触发方式/形状/开关）、虚拟按键画布

## 本地运行
```bash
flutter pub get
flutter run          # Android / iOS
flutter build apk    # 安卓安装包
```

## CI
推送到 `main` 自动构建 APK，产物在 Actions → 该次运行 → Artifacts 下载。
