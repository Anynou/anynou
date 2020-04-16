provider "google" {
	region = "us-central1"
	zone = "us-central1-a"
	project = "my-project"
	credentials = "${file("terraform.json")}"
}