---
title: "keep-sortedでコード内リストを自動ソート管理する"
emoji: "🔄"
type: "tech"
topics: ["git", "開発環境", "自動化", "linter"]
published: false
---

## なぜソートが必要なのか

ソートには以下のような利点があります：

### 1. 重複の発見

設定ファイルで同じキーを複数回定義してしまい、意図しない動作になったことはありませんか？(ちなみに私はないです）

```yaml
allow_warping: false
enable_two_players: false
show_end_credits: true
enable_frost_band: false
enable_two_players: true  # 重複に気づきにくい
```

ソートすると重複が明確になりますね：

```yaml
# keep-sorted start
allow_warping: false
enable_frost_band: false
enable_two_players: false
enable_two_players: true  # 重複が隣接して発見しやすい
show_end_credits: true
# keep-sorted end
```

参考: [Sort Lines in Source Code - Google Testing Blog](https://testing.googleblog.com/2025/09/sort-lines-in-source-code.html)

### 2. 可読性とメンテナンス性の向上

- アルファベット順になっていると、特定の項目を探しやすい
- 追加・削除の差分が明確になる
- マージコンフリクトが発生しにくくなる

### 3. レビューの負担軽減

「ソート順を揃えてください」というコメントが不要になります。

## keep-sortedとは

keep-sortedは、Googleが開発した**ファイル内の特定セクションを自動的にソートするツール**です。

https://github.com/google/keep-sorted

言語非依存で、マーカーで囲んだ部分を自動的にアルファベット順（または指定した順序）にソートしてくれます。

### 従来のツールとの違い

ソートツールには以下のようなものがあります：

**言語専用ツール（import文に特化）**
- Python: `isort`, `black`
- Go: `goimports`
- JavaScript: `eslint-plugin-import`

**汎用テキストソートツール**
- UNIXの`sort`コマンド
- エディタのソート機能

言語専用ツールはimport文に特化しており、その他のリストには使えません。汎用ツールは任意のテキストをソートできますが、言語の構文やコンテキストを理解しません。

keep-sortedはその中間的な存在で：
- **言語非依存** - あらゆるファイル形式で使える
- **柔軟なソート対象** - 明示的にマーカーで囲んだ部分をソート
- **細かい制御** - オプションで順序をカスタマイズ（numeric、prefix_orderなど）

## インストール

Go 1.23以上が必要です。

```bash
go install github.com/google/keep-sorted@v0.7.1
```

## 基本的な使い方

ソートしたい部分を `keep-sorted start` と `keep-sorted end` で囲むだけです。

```java
@Component(
    modules = {
      // keep-sorted start
      UtilsModule.class,
      GetRequestModule.class,
      PostRequestModule.class,
      AuthModule.class,
      // keep-sorted end
    })
```

keep-sortedを実行すると：

```bash
keep-sorted example.java
```

自動的にソートされます：

```java
@Component(
    modules = {
      // keep-sorted start
      AuthModule.class,
      GetRequestModule.class,
      PostRequestModule.class,
      UtilsModule.class,
      // keep-sorted end
    })
```

## 実用的なユースケース

### Expressのルーティング定義

HTTPメソッドを無視して、エンドポイント名でソートする：

```javascript
// keep-sorted start ignore_prefixes=app.get,app.post,app.put,app.delete
app.post('/auth/login', loginHandler);
app.get('/users', getUsersHandler);
app.delete('/users/:id', deleteUserHandler);
app.post('/users', createUserHandler);
app.get('/posts', getPostsHandler);
app.put('/posts/:id', updatePostHandler);
app.get('/comments', getCommentsHandler);
// keep-sorted end
```

実行後、エンドポイント別にグループ化されます：

```javascript
// keep-sorted start ignore_prefixes=app.get,app.post,app.put,app.delete
app.post('/auth/login', loginHandler);
app.get('/comments', getCommentsHandler);
app.get('/posts', getPostsHandler);
app.put('/posts/:id', updatePostHandler);
app.post('/users', createUserHandler);
app.get('/users', getUsersHandler);
app.delete('/users/:id', deleteUserHandler);
// keep-sorted end
```

ルーティング定義が多い場合に、この整理が役立ちます。

### Markdownテーブル

ヘッダー行をスキップして内容だけソート：

```markdown
<!-- keep-sorted start skip_lines=2 -->
| Name | Age | City |
|------|-----|------|
| Charlie | 35 | Tokyo |
| Alice | 28 | Osaka |
| Bob | 42 | Kyoto |
<!-- keep-sorted end -->
```

実行後：

```markdown
<!-- keep-sorted start skip_lines=2 -->
| Name | Age | City |
|------|-----|------|
| Alice | 28 | Osaka |
| Bob | 42 | Kyoto |
| Charlie | 35 | Tokyo |
<!-- keep-sorted end -->
```

## オプション

keep-sortedには豊富なオプションがあります。上の例で使った：

- `ignore_prefixes` - 特定のプレフィックスを無視してソート
- `prefix_order` - カスタム順序を指定
- `skip_lines=N` - 先頭N行をスキップ

その他にも `numeric=yes`（数値ソート）、`case=no`（大文字小文字を区別しない）など様々なオプションがあります。

詳細は[公式README](https://github.com/google/keep-sorted?tab=readme-ov-file#options)を参照してください。

## pre-commitとの統合

`.pre-commit-config.yaml`に以下を追加：

```yaml
repos:
  - repo: https://github.com/google/keep-sorted
    rev: v0.7.1
    hooks:
      - id: keep-sorted
```

コミット時に自動的にソートされます。

```bash
$ git commit -m "Add unsorted list"
keep-sorted..............................................................Failed
- files were modified by this hook
```

ファイルが自動修正されるので、再度コミットすれば成功します：

```bash
$ git add .
$ git commit -m "Add sorted list"
keep-sorted..............................................................Passed
```

## GitHub Actionsとの統合

pre-commitをスキップした変更を検知するため、CIでもチェックを行うことができます。

`.github/workflows/keep-sorted.yml`を作成：

```yaml
name: keep-sorted

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  check-sorted:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5
        with:
          go-version: '1.23'

      - name: Install keep-sorted
        run: go install github.com/google/keep-sorted@v0.7.1

      - name: Check if files are sorted
        run: keep-sorted --mode=lint .
```

`--mode=lint` はチェックのみ行い、ファイルを変更しません。ソートされていなければCIが失敗します。

### lint modeの出力例

```bash
$ keep-sorted --mode=lint unsorted.txt
```

```json
[
  {
    "path": "unsorted.txt",
    "lines": { "start": 2, "end": 5 },
    "message": "These lines are out of order.",
    "fixes": [{
      "replacements": [{
        "lines": { "start": 2, "end": 5 },
        "new_content": "apple\nbanana\ncherry\nzebra\n"
      }]
    }]
  }
]
```

## ベストプラクティス

### ローカルとCIの組み合わせ

1. **ローカル（pre-commit）** - 自動修正で開発者の利便性を向上
2. **CI（GitHub Actions）** - 品質ゲートとして機能

この組み合わせで、ソート順の問題を削減できます。

### 適切な粒度で使う

すべてをソートする必要はありません。マージコンフリクトが起きやすい部分や、順序を統一したい部分に限定して使いましょう。

## まとめ

keep-sortedは：

- **マージコンフリクトを削減** - 自動ソートで順序を統一
- **言語非依存** - あらゆるファイル形式で使える
- **柔軟** - 豊富なオプションで細かく制御
- **自動化** - pre-commit/GitHub Actionsで運用可能

特に以下のような用途で活用できます：
- APIルーティング定義
- 設定ファイル
- enumや定数リスト
- Markdownテーブル

チーム開発でのコンフリクトを減らし、レビューをスムーズにするための選択肢として検討してみてください。
