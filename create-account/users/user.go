package users

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

// アカウント作成のストラクト
type UserData struct {
	UserName     string `json:"user_name,omitempty"`
	UserMail     string `json:"user_mail,omitempty"`
	UserPassword string `json:"user_password,omitempty"`
	UserIcon     string `json:"user_icon,omitempty"`
}

// アカウント作成関数
func CreateAccount(ctx *gin.Context) {
	// errorを返すリスト
	var errorArray []string

	name := ctx.DefaultPostForm("name", "名無しさん")
	mail := ctx.DefaultPostForm("mail", "")
	pw := ctx.DefaultPostForm("pw", "")
	// TODO: デフォルト決め打ち -> AWS S3のパスをぶちこむ
	Icon := "Default"

	if err := ValidationName(name); err != nil {
		errorArray = append(errorArray, err.Error())
	}

	if err := ValidationMail(mail); err != nil {
		errorArray = append(errorArray, err.Error())
	}

	if err := ValidationPW(pw); err != nil {
		errorArray = append(errorArray, err.Error())
	}

	fmt.Println("バリデーションエラーの種類 -> ", errorArray)
	if len(errorArray) == 0 {
		userData := UserData{
			UserName:     name,
			UserMail:     mail,
			UserPassword: pw,
			UserIcon:     Icon,
		}

		if SqlCreateAccount(userData) {
			ctx.Header("Content-Type", "application/json; charset=utf-8")
			ctx.JSON(200, userData)
		} else {
			ctx.Header("Content-Type", "text/html; charset=UTF-8")
			ctx.String(200, "<h1>SQL ERROR</h1>")
		}
	} else {
		ctx.Header("Content-Type", "application/json; charset=UTF-8")
		ctx.JSON(200, errorArray)
	}
}

//　func アカウント編集
// GOのSDKでS3からアイコンのパスみたいなやつをもってきてぶちこむ

//func
