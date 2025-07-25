package routes

import (
	"github.com/gin-gonic/gin"
	"pg-backend/controller/run"
)

func RegisterV1Group(router *gin.Engine) {
	v1 := router.Group("/api/v1")
	{
		v1.POST("/run", run.Post)
	}
}