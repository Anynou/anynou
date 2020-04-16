resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  depends_on = [ google_compute_network.kubernetes,]

  metadata_startup_script = "sudo add-apt-repository universe; sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main >> /etc/apt/sources.list.d/kubernetes.list; sudo apt-get update;sudo apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni nfs-kernel-server nfs-common; sudo swapoff -a; sudo systemctl daemon-reload; sudo systemctl restart kubelet; sudo systemctl enable docker.service"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
    
  }
  can_ip_forward = "true"

  network_interface {
    subnetwork = "${google_compute_subnetwork.kube.name}"
    access_config {
      network_tier = "STANDARD"
    }
  }

}

resource "google_compute_instance" "worker1" {
  name         = "worker1"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  depends_on = [ google_compute_network.kubernetes,]

  metadata_startup_script = "sudo add-apt-repository universe; sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main >> /etc/apt/sources.list.d/kubernetes.list; sudo apt-get update;sudo apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni nfs-kernel-server nfs-common; sudo swapoff -a; sudo systemctl daemon-reload; sudo systemctl restart kubelet; sudo systemctl enable docker.service; sudo apt install ceph-common"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
    
  }
  can_ip_forward = "true"

  network_interface {
    subnetwork = "${google_compute_subnetwork.kube.name}"
    
    access_config {
      network_tier = "STANDARD"
    }
  }

}

resource "google_compute_instance" "worker2" {
  name         = "worker2"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  depends_on = [ google_compute_network.kubernetes,]

  metadata_startup_script = "sudo add-apt-repository universe; sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main >> /etc/apt/sources.list.d/kubernetes.list; sudo apt-get update;sudo apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni nfs-kernel-server nfs-common; sudo swapoff -a; sudo systemctl daemon-reload; sudo systemctl restart kubelet; sudo systemctl enable docker.service; sudo apt install ceph common"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
    
  }
  can_ip_forward = "true"

  network_interface {
    subnetwork = "${google_compute_subnetwork.kube.name}"
    
    access_config {
      network_tier = "STANDARD"
    }
  }

}
