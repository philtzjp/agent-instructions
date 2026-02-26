#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/osaxyz/claudecode-skills"
BRANCH="main"
TARBALL_URL="${REPO_URL}/archive/refs/heads/${BRANCH}.tar.gz"
TMP_DIR="$(mktemp -d)"
SKILL_DIR="commands"

cleanup() {
    rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

echo "=== OSA Claude Code Skills — Installer ==="
echo ""

# ------------------------------------
# 1. インストール先の選択
# ------------------------------------
echo "インストール先を選択してください:"
echo "  1) このリポジトリ直下 (.claude/commands/)"
echo "  2) ユーザーホーム (~/.claude/commands/)"
echo ""
printf "選択 [1/2]: "
read -r choice

case "${choice}" in
    1)
        INSTALL_DIR="$(pwd)/.claude/commands"
        ;;
    2)
        INSTALL_DIR="${HOME}/.claude/commands"
        ;;
    *)
        echo "エラー: 1 または 2 を入力してください"
        exit 1
        ;;
esac

echo ""
echo "インストール先: ${INSTALL_DIR}"
echo ""

# ------------------------------------
# 2. 最新版のダウンロード
# ------------------------------------
echo "最新版をダウンロード中..."
curl -fsSL "${TARBALL_URL}" -o "${TMP_DIR}/skills.tar.gz"
tar -xzf "${TMP_DIR}/skills.tar.gz" -C "${TMP_DIR}" --strip-components=1

# ------------------------------------
# 3. バージョン比較
# ------------------------------------
REMOTE_VERSION_FILE="${TMP_DIR}/VERSION"
VERSION_DIR="${INSTALL_DIR}/../osa"
LOCAL_VERSION_FILE="${VERSION_DIR}/VERSION"

remote_version="unknown"
local_version="none"

if [ -f "${REMOTE_VERSION_FILE}" ]; then
    remote_version="$(cat "${REMOTE_VERSION_FILE}")"
fi

if [ -f "${LOCAL_VERSION_FILE}" ]; then
    local_version="$(cat "${LOCAL_VERSION_FILE}")"
fi

if [ "${remote_version}" = "${local_version}" ]; then
    echo "すでに最新バージョン (${local_version}) です。アップデートは不要です。"
    exit 0
fi

echo "ローカル: ${local_version}"
echo "リモート: ${remote_version}"
echo ""

# ------------------------------------
# 4. インストール
# ------------------------------------
mkdir -p "${INSTALL_DIR}"

if [ -d "${TMP_DIR}/${SKILL_DIR}" ]; then
    cp -R "${TMP_DIR}/${SKILL_DIR}/"* "${INSTALL_DIR}/"
    echo "スキルファイルをインストールしました。"
else
    echo "警告: リポジトリに ${SKILL_DIR}/ ディレクトリが見つかりません。"
    echo "リポジトリ直下のファイルをコピーします。"
    cp -R "${TMP_DIR}/"*.md "${INSTALL_DIR}/" 2>/dev/null || true
fi

# VERSION ファイルをコピー
if [ -f "${REMOTE_VERSION_FILE}" ]; then
    mkdir -p "${VERSION_DIR}"
    cp "${REMOTE_VERSION_FILE}" "${LOCAL_VERSION_FILE}"
fi

echo ""
echo "=== インストール完了 (${remote_version}) ==="
