package main

import (
	"bytes"
	"io"
	"log"

	"filippo.io/age"
)

/*
# Initial Example

- Generate a Private key
- Get the Public Key
- Create Recipient from Public Key
- Encrypt the data using the Recipient to Buffer
- Decrypt the data again using the Public Key
*/

func main() {
	// Step 1: Generate encryption keys in memory
	// Generate a new key pair (private and public keys)
	privateKey, err := age.GenerateX25519Identity()
	if err != nil {
		log.Fatalf("Error generating private key: %v", err)
	}
	publicKey := privateKey.Recipient().String()

	// Print public key to share for encryption (in the real world, this would be shared with others)
	log.Printf("Public Key: %s \n", publicKey)

	// Step 2: Encrypt some data
	// Data to encrypt
	data := []byte("Hello, this is a secret message!")

	// Create a new Age encryption recipient using the public key
	recipient, err := age.ParseX25519Recipient(publicKey)
	if err != nil {
		log.Fatalf("Error in parsing the Public key: %v", err)
	}

	// Storage for Encrypted data - To provide the IO Writer like Interface
	out := &bytes.Buffer{}

	// Encrypt the data
	encryptedFile, err := age.Encrypt(out, recipient)
	if err != nil {
		log.Fatalf("Error creating encryption stream: %v", err)
	}

	// Safety just in case there was any error in Writing
	defer encryptedFile.Close()

	// Write the encrypted data to the encryption stream
	_, err = encryptedFile.Write(data)
	if err != nil {
		log.Fatalf("Error writing encrypted data: %v", err)
	}

	// Close the file normally
	encryptedFile.Close()

	// Display the Encrypted Data
	log.Printf("Encrypted: %x", out.Bytes())

	// Read encrypted data (simulating a file or a stream) - IO Reader interface
	encryptedData := bytes.NewBuffer(out.Bytes())
	// Step 3: Decrypt the encrypted data
	// Decrypt the data using the private key
	decoder, err := age.Decrypt(encryptedData, privateKey)
	if err != nil {
		log.Fatalf("Error decoding data: %v", err)
	}

	// Read the decrypted message
	decryptedData, err := io.ReadAll(decoder)
	if err != nil {
		log.Fatalf("Error reading decrypted data: %v", err)
	}

	// Print the decrypted message
	log.Printf("Decrypted message: %s\n", decryptedData)
}
