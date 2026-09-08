package main

import (
	"crypto/aes"
	"crypto/cipher"
	"encoding/hex"
	"fmt"
	"strings"
)

func main() {
	// Load your secret key from a safe place and reuse it across multiple
	// Seal/Open calls. (Obviously don't use this example key for anything
	// real.) If you want to convert a passphrase to a key, use a suitable
	// package like bcrypt or scrypt.
	// When decoded the key should be 16 bytes (AES-128) or 32 (AES-256).
	key, _ := hex.DecodeString("00112233445566778899AABBCCDDEEFFFFEECCDDBBAA99887766554433221100")
	// Input in <hex-IV>|<hex-TAG>|<hex-CT> Format
	input := "FE1B8267169A55D6FCFD5D9A|90F20C8D0D1DE4C2D5CF705D705BAF56|38013B70DFE92E3B9225D8E51B033FEE"
	parts := strings.Split(input, "|")
	if len(parts) < 2 {
		fmt.Println("Incorrect input there are no 3 parts")
		return
	}
	ciphertext, _ := hex.DecodeString(parts[2] + parts[1])
	nonce, _ := hex.DecodeString(parts[0])

	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err.Error())
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err.Error())
	}

	plaintext, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		panic(err.Error())
	}

	fmt.Printf("%s\n", plaintext)
}
