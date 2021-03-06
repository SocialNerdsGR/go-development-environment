package main

import (
	"testing"
)

func TestGetResponse(t *testing.T) {
	response := GetResponse()
	if response != "Hello SocialNerds!" {
		t.Errorf("Wrong response: %v", response)
	}
}
