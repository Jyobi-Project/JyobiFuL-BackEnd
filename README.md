# Jyobi-Project

## db接続手順書
### 事前準備
- [mysqlをubuntuにインストール](https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-databasem, "公式ドキュメント")
- [パスワード設定でエラー起きたときの処理](https://exerror.com/failed-error-set-password-has-no-significance-for-user-rootlocalhost-as-the-authentication-method-used-doesnt-store-authentication-data-in-the-mysql-server/, "エラー時の参考")

### goの設定
- githubのコードを落としておく
```go
go get "github.com/jinzhu/gorm"
go get github.com/go-sql-driver/mysql
```
### ddlを実行
- main階層にあるddl.sqlを実行

### ????
goを実行するときにはsudoをつけるとワーニングがでない
面倒くさいので誰か原因究明よろしく

## webアプリの実行

### goの設定
```go
git mod init フォルダ名
を実行しgo.modファイルを生成する(既に実行済みの場合は不要
```

- githubのコードを落としておく
```GO
go get github.com/gin-gonic/gin@v1.7.4
```

### 注意点
- サーバーの停止はctrl+cでやること
- staticフォルダはgopathで設定したプロジェクト直下に置くこと
