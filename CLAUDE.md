# Coding Guidelines for colaxy_adaptive_scaffold

このドキュメントは、`colaxy_adaptive_scaffold` プロジェクトのコーディングルールとガイドラインを定義します。

## ファイル構成のルール

### 1. クラスの分離
- **各クラスは独立したファイルに配置する**
  - 1つのファイルには1つの主要なクラスのみを定義
  - ファイル名はクラス名のスネークケース版（例: `NavigationItem` → `navigation_item.dart`）
  - 関連する小さなヘルパークラスは同じファイルに含めても良い

### 2. ディレクトリ構造
```
lib/
├── colaxy_adaptive_scaffold.dart  # メインのエクスポートファイル
└── src/                           # 実装ファイル
    ├── adaptive_scaffold.dart     # AdaptiveScaffoldクラス
    ├── navigation_item.dart       # NavigationItemクラス
    └── ...                        # その他のクラス
```

### 3. エクスポート管理
- すべての公開クラスは `lib/colaxy_adaptive_scaffold.dart` からエクスポート
- 内部実装の詳細は `src/` ディレクトリに配置
- ユーザーは `import 'package:colaxy_adaptive_scaffold/colaxy_adaptive_scaffold.dart';` のみをインポート

## ドキュメンテーションのルール

### 1. クラスのドキュメント
すべての公開クラスには以下を含む包括的なドキュメントを記述：

```dart
/// クラスの簡潔な説明（1行）
///
/// より詳細な説明（複数行可）
/// - 機能の説明
/// - 使用方法
/// - 注意事項
///
/// ## Parameters (パラメータがある場合)
///
/// ### Required Parameters
/// - **[paramName]**: パラメータの説明
///
/// ### Optional Parameters
/// - **[paramName]**: パラメータの説明
///   - デフォルト値の説明
///   - 使用例
///
/// ## Example
///
/// ```dart
/// // 使用例のコード
/// ```
class MyClass {
  // ...
}
```

### 2. パラメータのドキュメント
各パラメータには詳細なドキュメントを記述：

```dart
/// パラメータの簡潔な説明
///
/// より詳細な説明（必要に応じて）
/// - 動作の詳細
/// - デフォルト値
/// - 制約事項
final Type parameterName;
```

### 3. README.md の更新
新機能や変更を加えた場合は、必ず `README.md` を更新：

- **Features セクション**: 主要な機能を箇条書きで説明
- **Usage セクション**: 基本的な使用例と高度な使用例を含める
- **API Reference セクション**: すべての公開クラスとパラメータを文書化
- **How It Works セクション**: 内部動作の概要を説明

## コーディングスタイル

### 1. 命名規則
- **クラス名**: PascalCase（例: `AdaptiveScaffold`, `NavigationItem`）
- **ファイル名**: snake_case（例: `adaptive_scaffold.dart`, `navigation_item.dart`）
- **変数・パラメータ**: camelCase（例: `selectedIndex`, `aspectRatioThreshold`）
- **定数**: lowerCamelCase（例: `defaultThreshold`）

### 2. コメント
- 日本語と英語の両方を適切に使用
- 公開APIは英語でドキュメント化
- 内部実装のコメントは日本語でも可

### 3. コードの整理
- 関連する機能は近くに配置
- パブリックメンバーを先に、プライベートメンバーを後に
- 論理的な順序でメソッドを配置（ライフサイクルメソッド → ビルドメソッド → ヘルパーメソッド）

## 設計原則

### 1. シンプルさを保つ
- APIはシンプルで直感的に
- デフォルト値を適切に設定し、ほとんどのケースで追加設定不要に
- 複雑な設定は必要な場合のみ公開

### 2. 柔軟性
- カスタマイズ可能なパラメータを提供
- 合理的なデフォルト値を設定
- 拡張可能な設計

### 3. ドキュメント優先
- すべての公開APIは完全にドキュメント化
- 使用例を含める
- パラメータの意味と効果を明確に説明

## 変更管理

### 1. 破壊的変更
- 既存のAPIを変更する場合は、まず非推奨化（@deprecated）
- 代替手段を提供
- CHANGELOG.md に記録

### 2. 新機能追加
- README.md を更新
- 使用例を追加
- テストを追加（該当する場合）

### 3. バグ修正
- 問題の説明をコミットメッセージに記載
- 可能であればテストケースを追加

## チェックリスト

新しいクラスや機能を追加する際のチェックリスト：

- [ ] クラスは独立したファイルに配置されているか
- [ ] クラスに包括的なドキュメントがあるか
- [ ] すべてのパラメータにドキュメントがあるか
- [ ] 使用例が含まれているか
- [ ] `lib/colaxy_adaptive_scaffold.dart` からエクスポートされているか
- [ ] README.md が更新されているか
- [ ] API Reference セクションが更新されているか
- [ ] 使用例が README.md に追加されているか
