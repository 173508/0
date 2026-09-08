package main

import (
	"bytes"
	"fmt"
	"log"

	"github.com/schollz/pake"
)

func main() {
	// both parties should have a weak key
	weakKey := []byte{1, 2, 3}

	// initialize A
	A, err := pake.InitCurve(weakKey, 0, "siec")
	if err != nil {
		log.Fatalln(err)
	}
	// initialize B
	B, err := pake.InitCurve(weakKey, 1, "siec")
	if err != nil {
		log.Fatalln(err)
	}

	// send A's stuff to B
	err = B.Update(A.Bytes())
	if err != nil {
		log.Fatalln(err)
	}

	// send B's stuff to A
	err = A.Update(B.Bytes())
	if err != nil {
		log.Fatalln(err)
	}

	// both P and Q now have strong key generated from weak key
	kA, _ := A.SessionKey()
	kB, _ := B.SessionKey()
	fmt.Println(bytes.Equal(kA, kB))
}
