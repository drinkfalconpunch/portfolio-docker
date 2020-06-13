package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"time"
)

type PageVariables struct {
	Date string
	Time string
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Missing port number")
		os.Exit(0)
	}
	port := os.Args[1]
	a := fmt.Sprintf("%s%s", ":", port)
	fmt.Printf("Starting webpage at port %s.\n", port)
	http.HandleFunc("/", HomePage)
	log.Fatal(http.ListenAndServe(a, nil))
}

func HomePage(w http.ResponseWriter, r *http.Request) {
	now := time.Now()
	HomePageVars := PageVariables{
		Date: now.Format("01-02-2006"),
		Time: now.Format("3:04:05 PM"),
	}

	t, err := template.ParseFiles("static/index.html")
	if err != nil {
		log.Print("Template parsing error: ", err)
	}
	err = t.Execute(w, HomePageVars)
	if err != nil {
		log.Print("Template executing error: ", err)
	}
}
