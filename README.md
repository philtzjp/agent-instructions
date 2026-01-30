# Agent Instructions

> A collection of instruction documents for AI agents used by Philtz members.

PhiltzメンバーがAIエージェントに与える指示ドキュメントをまとめたリポジトリです。

---

## Structure

各ディレクトリにメンバーごとの指示ファイルが格納されています。

```
├── ouchiarata/
│   └── CLAUDE.md    # Claude Code 用の指示ファイル
└── ...
```

## Usage

`CLAUDE.md`は[Claude Code](https://docs.anthropic.com/en/docs/claude-code)がプロジェクトのコンテキストとして読み込む設定ファイルです。

自分のディレクトリ内の`CLAUDE.md`を`~/.claude/CLAUDE.md`にコピーまたはシンボリックリンクすることで、全プロジェクト共通の指示として適用できます。

```bash
ln -sf /path/to/agent-instructions/<your-name>/CLAUDE.md ~/.claude/CLAUDE.md
```

## Connect with Us

私たちの活動に関するより詳しい情報は、公式サイトをご覧ください。

- **Official Website:** https://philtz.com
