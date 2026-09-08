// main.go - Secure File Download Example
//
//     ॐ भूर्भुवः स्वः
//     तत्स॑वि॒तुर्वरे॑ण्यं॒
//    भर्गो॑ दे॒वस्य॑ धीमहि।
//   धियो॒ यो नः॑ प्रचो॒दया॑त्॥
//
// ===========================
//   बोसजी के द्वारा रचित सुलभ दृष्टान्त
// ===========================
//
// +-------------------------+
// |   एक रचनात्मक भारतीय उत्पाद।   |
// +-------------------------+
//
// Sources
// -------
// https://gist.github.com/boseji/
//
// License
// -------
//
// SPDX: GPL-3.0-or-later
//
//   Boseji's Secure File Download Example
//   Copyright (C) 2024 by Abhijit Bose (aka. Boseji)
//
//   This program is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by the
//   Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty
//   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//   See the GNU General Public License for more details.
//
//   You should have received a copy of the GNU General Public License along
//   with this program. If not, see <https://www.gnu.org/licenses/>.
//

// Secure File Download Example
package main

import (
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

func main() {
	fileURL := "https://test.mosquitto.org/ssl/mosquitto.org.crt"
	log.Println("* Starting Secure Downloader by Boseji")
	log.Println("    We are going to download the secure certificate from")
	log.Println("    mosquitto.org the MQTT testing broker website.")
	log.Printf("    Here is the URL:\n\n    %s\n\n", fileURL)
	fileName, _ := filepath.Abs(filepath.Join("./", filepath.Base(fileURL)))
	log.Printf("    The file that would be created:\n\n   %s\n\n", fileName)

	// Create Secure connection Transport Layer
	// - The IdleConnTimeout needs to be edited based on the size
	//   of the download and the speed of the server.
	//   Bigger the value the longer the client will wait for the
	//   request to be acknowledged.
	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	// Setup client with the Transport
	client := &http.Client{Transport: tr}

	log.Println("** Downloading file - please wait ...")

	// Perform the Request for the File
	resp, err := client.Get(fileURL)
	if err != nil {
		log.Fatalln("failed to send GET request:", err)
	}
	defer resp.Body.Close()
	log.Println("    Download request acknowledged.")

	// Read out the Data from the request
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln("failed to read body:", err)
	}
	log.Println("** Data Received:\n\n", string(body))

	// Write the data to the file
	err = os.WriteFile(fileName, body, 0600)
	if err != nil {
		log.Fatalln("failed to write file:", err)
	}
	log.Println("** File Write Successful")
}
