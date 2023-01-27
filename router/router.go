package router

import (
  "Jyobi-Project/question/createQuestion"
  "Jyobi-Project/question/getQuestion"
  "Jyobi-Project/question/questionList"
  "net/http"
  "time"

  "github.com/gin-contrib/cors"
  "github.com/gin-gonic/gin"
)

func GetRouter() *gin.Engine {
  r := gin.Default()

  // ここからCorsの設定
  r.Use(cors.New(cors.Config{
    // アクセスを許可したいアクセス元
    AllowOrigins: []string{
      "http://localhost:3000",
    },
    // アクセスを許可したいHTTPメソッド(以下の例だとPUTやDELETEはアクセスできません)
    AllowMethods: []string{
      "POST",
      "GET",
      "OPTIONS",
    },
    // 許可したいHTTPリクエストヘッダ
    AllowHeaders: []string{
      "Access-Control-Allow-Credentials",
      "Access-Control-Allow-Headers",
      "Content-Type",
      "Content-Length",
      "Accept-Encoding",
      "Authorization",
    },
    // cookieなどの情報を必要とするかどうか
    AllowCredentials: true,
    // preflightリクエストの結果をキャッシュする時間
    MaxAge: 24 * time.Hour,
  }))

  r.StaticFS("/static", http.Dir("static"))

  // 問題登録ページ（サンプル）
  q := r.Group("/question")
  {
    // 問題を登録する
    q.POST("/create", createQuestion.InsertQuestion)
    // 問題を取得する
    q.POST("/get", getQuestion.GetQuestion)
    // 問題の一覧を取得する
    q.POST("/list", questionList.SelectQuestion)
  }

  return r
}
