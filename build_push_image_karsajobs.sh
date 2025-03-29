#!/bin/bash
 
# build Docker image dari Dockerfile
echo "Membuat Docker image..."
docker build -t karsajobs:latest .
 
# menampilkan daftar image yang ada di lokal
echo "Daftar Docker image lokal:"
docker images
 
# mengubah nama image agar sesuai dengan format Docker Hub
echo "Mengubah nama image..."
docker tag karsajobs:latest ardaiyansyah/karsajobs:latest
 
# login ke Docker Hub
echo "Login ke Docker Hub..."
docker login
 
# mengunggah image ke Docker Hub
echo "Mengunggah image ke Docker Hub..."
docker push ardaiyansyah/karsajobs:latest
 
echo "Proses build dan push selesai pada Dockerhub!"
 
# mengubah nama image agar sesuai dengan format GitHub Packages
echo "Mengubah nama image..."
docker tag karsajobs:latest ghcr.io/macreai/karsajobs:latest
 
# login ke Github Packages
echo $CR_PAT | docker login ghcr.io -u macreai --password-stdin
 
# mengunggah image ke GitHub Packages
docker push ghcr.io/macreai/karsajobs:latest
 
echo "Proses build dan push selesai pada Github Packages!"