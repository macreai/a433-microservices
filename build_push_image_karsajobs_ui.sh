#!/bin/bash
 
# build Docker image dari Dockerfile
echo "Membuat Docker image..."
docker build -t karsajobs-ui:latest .
 
# menampilkan daftar image yang ada di lokal
echo "Daftar Docker image lokal:"
docker images
 
# mengubah nama image agar sesuai dengan format Docker Hub
echo "Mengubah nama image..."
docker tag karsajobs-ui:latest ardaiyansyah/karsajobs-ui:latest
 
# login ke Docker Hub
echo "Login ke Docker Hub..."
echo $DOCKER_HUB_PW | docker login -u ardaiyansyah --password-stdin
 
# mengunggah image ke Docker Hub
echo "Mengunggah image ke Docker Hub..."
docker push ardaiyansyah/karsajobs-ui:latest
 
echo "Proses build dan push selesai pada Dockerhub!"
 
# mengubah nama image agar sesuai dengan format GitHub Packages
echo "Mengubah nama image..."
docker tag karsajobs-ui:latest ghcr.io/macreai/karsajobs-ui:latest
 
# login ke Github Packages
echo $CR_PAT | docker login ghcr.io -u macreai --password-stdin
 
# mengunggah image ke GitHub Packages
docker push ghcr.io/macreai/karsajobs-ui:latest
 
echo "Proses build dan push selesai pada Github Packages!"