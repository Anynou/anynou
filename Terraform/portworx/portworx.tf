resource "google_compute_disk" "portworx1" {
  name = "portworxextra1"
  size = 20
}

resource "google_compute_instance" "masterportworx" {
  name         = "master-portworx"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  depends_on = [ google_compute_network.kubernetes,]

  metadata = {
    startup-script = <<SCRIPT
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
      apt-get update && apt-get install -y docker.io 
      systemctl enable docker.service
      export IP=10.128.0.111
      docker run -d --net=host -p 4001:2379 \
      --volume=/var/lib/px-etcd:/etcd-data \
      --name etcd quay.io/coreos/etcd /usr/local/bin/etcd \
      --data-dir=/etcd-data --name node1 \
      --advertise-client-urls http://10.128.0.111:4001 \
      --listen-client-urls http://10.128.0.111:4001 \
      --initial-advertise-peer-urls http://10.128.0.111:2380 \
      --listen-peer-urls http://10.128.0.111:2380 \
      --initial-cluster node1=http://10.128.0.111:2380
    SCRIPT
  } 
    

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
    
  }

  can_ip_forward = "true"

  network_interface {
    subnetwork = "${google_compute_subnetwork.kube.name}"
    network_ip ="10.128.0.111"
    access_config {
      network_tier = "STANDARD"
    }
  }

}

resource "google_compute_instance" "nodo1" {
  name         = "nodo1-portworx"
  machine_type = "n1-standard-4"
  zone         = "us-central1-a"

  depends_on = [ google_compute_network.kubernetes,google_compute_instance.masterportworx]

  metadata = {
    startup-script = <<SCRIPT
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
      apt-get update && apt-get install -y docker.io 
      systemctl enable docker.service
      latest_stable=$(curl -fsSL "https://install.portworx.com/?type=dock&stork=false" | awk '/image: / {print $2}') && echo "latest_stable=$latest_stable" >> ~/.bashrc
      docker run --entrypoint /runc-entry-point.sh \
      --rm -i --privileged=true \
      -v /opt/pwx:/opt/pwx -v /etc/pwx:/etc/pwx \
      $latest_stable
      /opt/pwx/bin/px-runc install -c demo-px-cluster \
      -k etcd://10.128.0.111:4001 \
      -s /dev/sdb
      systemctl daemon-reload
      systemctl enable portworx
      systemctl start portworx
    SCRIPT
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
    
  }

  attached_disk {
    device_name = "portworxextra1"
    mode        = "READ_WRITE"
    source = "${google_compute_disk.portworx1.self_link}"
  }

  can_ip_forward = "true"

  network_interface {
    subnetwork = "${google_compute_subnetwork.kube.name}"
    network_ip ="10.128.0.112"
    access_config {
      network_tier = "STANDARD"
    }
  }

}


