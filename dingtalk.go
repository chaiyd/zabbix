package main

import (
	"github.com/CatchZeng/dingtalk"
	"os"
)

func main() {
	accessToken := "9e493678d7bd37eb875935xxxxxxxxxxxxxx" //更改为自己的机器人token
	secret := "SEC7b12ef6ebbcc7705d5cxxxxxxxxxxxxxxxxxxx" //机器人加签
	client := dingtalk.NewClient(accessToken, secret)
	msg := dingtalk.NewTextMessage().SetContent(os.Args[1]).SetAt([]string{"1700000000"}, false)
	client.Send(msg)

}
