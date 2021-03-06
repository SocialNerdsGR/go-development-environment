package main

import (
	"fmt"
)

func main() {
	fmt.Println(GetResponse())
}

// GetResponse returns a Hello World string.
func GetResponse() string {
	response := "Hello SocialNerds!"
	return response
}
