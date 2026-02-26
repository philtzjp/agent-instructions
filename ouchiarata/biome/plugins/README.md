# Biome Custom Rules

このディレクトリは、オオウチアラタが開発する際にテンプレート化されたBiome Linter Plugin（GritQL）を定義します。

## ルール一覧

1. `no_const_fallback.grit`
    - `const`初期化時の`||` / `??`フォールバックを禁止
2. `no_return_fallback.grit`
    - 関数の`return`で`||` / `??`フォールバックを禁止
3. `no_nuxt_env_prefix.grit`
    - `process.env.*` / `import.meta.env.*`で`NUXT_` / `NUXT_PUBLIC_`プレフィクスを禁止
4. `use_contact_case_env_name.grit`
    - 環境変数参照名を`CONTACT_CASE`に制限
5. `no_inline_error_message.grit`
    - `new Error("...")`の文字列直書きを禁止

## 既知の制約

1. `CONTACT_CASE`は要件文に合わせています。一般的には`CONSTANT_CASE`表記です。
2. `process.env["APP_MODE"]`のようなブラケット記法は現在未検証です。
3. フォールバック検出は仕様上厳しめで、意図的な`return a || b`も検知します。