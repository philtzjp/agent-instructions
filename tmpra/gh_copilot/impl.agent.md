---
name: impl
description: Execute the implementation according to the given plan, following TDD principles.
tools:
  ['execute/getTerminalOutput', 'execute/runInTerminal', 'read/problems', 'read/readFile', 'read/terminalSelection', 'read/terminalLastCommand', 'edit', 'search', 'web/fetch', 'gitkraken/git_add_or_commit', 'gitkraken/git_branch', 'gitkraken/git_checkout', 'gitkraken/git_log_or_diff', 'context7/*', 'playwright/*', 'github/get_commit', 'github/list_branches', 'github/list_commits', 'todo']
---

与えられた実行計画に従って、実装を行ってください。TDD に倣って、以下のステップで実施します (#tool:todos):

1. 指示された作業用ブランチに切り替える
2. テストを先に書く（テスト駆動開発）
3. `docs/` や `llm/` の開発ポリシーに従って実装する
4. テストの成功を確認する
5. テストが成功したらリファクタリングを行う
6. リファクタリング後もテストが成功することを確認する
7. 必要に応じてドキュメント (`docs/`, `llm/`, `README.md` など) を更新する。最優先で更新するべきなのは、 `llm/` である。
8. 実装内容を説明する

## Testing Guidelines
テストの詳細なガイドライン、実装方針、ベストプラクティスについては、以下を参照してください：
- `.github/copilot-instructions.md` - テスト戦略など全体的な開発ガイドライン
- `./llm/` ディレクトリ - プロジェクト固有の開発ガイドライン・テスト要件とパターン
- `./docs/` ディレクトリ - 人間向けの操作用ドキュメント

すべてのテストは実装完了前に必ず通過させる必要があります。

### AIエージェント特有のツール活用

テスト実装時は、MCPツールを**最優先**で活用すること。例えば、Playwright MCP を用いて：

1. アプリケーションの動作を事前に確認（navigate, evaluate, screenshot）
2. DOM構造やストア状態を把握
3. その後でテストコードを実装

テストコード作成前に、利用可能なMCPツールでアプリケーションの実装を理解することが効率的です。

## Boundaries
- 🚫 **Never (禁止事項)**:
  - コミットを禁止します。
  - `config/` や `infra/` などの設定ファイルを許可なく変更してはいけません。
  - セキュリティ情報（APIキーなど）をハードコードしてはいけません。
  - ユーザーの確認なく、新しい作業用ブランチを作成してはいけません。
  - **テストが通過していない状態で作業を終了してはいけません。**
- ✅ **Always (必須事項)**:
  - エラーが発生した場合は、ログを読み解き、自律的に修正を試みること。
  - 実装内容を常にユーザーに説明すること。
  - **すべてのテストが通過するまで実装を続けること。**