package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"io"
)

func main() {
	// Load your secret key from a safe place and reuse it across multiple
	// Seal/Open calls. (Obviously don't use this example key for anything
	// real.) If you want to convert a passphrase to a key, use a suitable
	// package like bcrypt or scrypt.
	// When decoded the key should be 16 bytes (AES-128) or 32 (AES-256).
	key, _ := hex.DecodeString("00112233445566778899AABBCCDDEEFFFFEECCDDBBAA99887766554433221100")
	plaintext := []byte("exampleplaintext")

	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err.Error())
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err.Error())
	}

	// Never use more than 2^32 random nonces with a given key because of the risk of a repeat.
	nonce := make([]byte, aesgcm.NonceSize())
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		panic(err.Error())
	}
	fmt.Printf("nonce : %X\n", nonce)

	ciphertext := aesgcm.Seal(nil, nonce, plaintext, nil)
	fmt.Printf("cipher: %X\n", ciphertext)
	fmt.Printf("Nonce Size: %d OverHead Size: %d (Tag) \n", aesgcm.NonceSize(), aesgcm.Overhead())
	fmt.Printf("Tag 16 Bytes: %X \n", ciphertext[(len(ciphertext)-aesgcm.Overhead()):])
	fmt.Printf("Only CypherText: %X \n", ciphertext[:(len(ciphertext)-aesgcm.Overhead())])
	fmt.Println("Formtted for CLI: Nonce|Tag|CT")
	fmt.Printf("%X|%X|%X\n", nonce, ciphertext[(len(ciphertext)-aesgcm.Overhead()):], ciphertext[:(len(ciphertext)-aesgcm.Overhead())])
}
