# Gunakan image node versi 14.21 yang berbasis Alpine Linux (ukuran kecil)
FROM node:14.21-alpine as builder

# Tentukan direktori kerja di dalam container menjadi '/app'
WORKDIR /app

# Salin file package.json dan package-lock.json ke dalam container, untuk instalasi dependensi
COPY package*.json ./

# Install semua dependensi yang tercatat di package.json
RUN npm install

# Salin semua file dari direktori proyek lokal ke dalam container
COPY . .

# Expose port 3000, yang akan digunakan untuk mengakses aplikasi di dalam container
EXPOSE 3000

# Tentukan perintah yang akan dijalankan ketika container di-start, dalam hal ini menjalankan aplikasi dengan 'npm run dev'
CMD [ "npm", "run", "dev" ]

