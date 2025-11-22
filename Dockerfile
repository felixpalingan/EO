# 1. Gunakan Python versi 3.11 yang ringan (slim)
FROM python:3.11-slim

# 2. Set folder kerja di dalam container
WORKDIR /app

# 3. Salin file requirements dulu (agar caching efisien)
COPY requirements.txt .

# 4. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Salin seluruh kode aplikasi ke dalam container
COPY . .

# 6. Buat folder instance untuk database (jika belum ada)
RUN mkdir -p instance

# 7. Buka port 8000 (Port standar Gunicorn)
EXPOSE 8000

# 8. Perintah untuk menjalankan aplikasi saat container hidup
# Kita pakai Gunicorn, bukan 'flask run'
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]