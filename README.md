# YT-DLP PowerShell Downloader

A simple **PowerShell-based YouTube downloader** using **yt-dlp** and **FFmpeg**.
This project allows you to download:

* 📹 YouTube videos (multiple formats & qualities)
* 🎵 Audio only (MP3, AAC, WAV, FLAC, OGG, etc.)
* 📱 Feature phone–friendly videos (low resolution & small size)

This repository contains two PowerShell scripts:

* `Main_YT-DLR.ps1` – Main interactive downloader script
* `Run.ps1` – Easy launcher script

---

## 📦 Requirements

Before using the scripts, you must install the following tools:

* **yt-dlp** (YouTube downloader engine)
* **FFmpeg** (for merging, converting, audio/video processing)
* **Windows PowerShell** (Windows 10/11 recommended)

---

## 🔧 Installation Guide

### 1️⃣ Install yt-dlp

#### Option A: Using Winget (Recommended)

```powershell
winget install yt-dlp
```

#### Option B: Manual Download

1. Download `yt-dlp.exe` from the official GitHub repository
2. Place it in a folder like:

   ```
   C:\yt-dlp\
   ```
3. Add this folder to **System PATH**

Verify installation:

```powershell
yt-dlp --version
```

---

### 2️⃣ Install FFmpeg

#### Option A: Using Winget

```powershell
winget install ffmpeg
```

#### Option B: Manual Download

1. Download FFmpeg (static build)
2. Extract it (example path):

   ```
   C:\ffmpeg\bin\
   ```
3. Add `bin` folder to **System PATH**

Verify installation:

```powershell
ffmpeg -version
```

---

## 📂 Project Files

```text
YT-DLP-PowerShell/
│
├── Main_YT-DLR.ps1   # Main interactive downloader
├── Run.ps1           # Quick run script
└── README.md         # Documentation
```

---

## ▶️ How to Run

### Step 1: Download or Clone Repository

```powershell
git clone https://github.com/your-username/YT-DLP-PowerShell.git
cd YT-DLP-PowerShell
```

Or download ZIP and extract it.

---

### Step 2: Enable PowerShell Script Execution

Run PowerShell **as Administrator** and execute:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

### Step 3: Run the Script

#### Easy Way (Recommended)

```powershell
.\Run.ps1
```

#### Direct Way

```powershell
.\Main_YT-DLR.ps1
```

---

## 🎛️ Features

* Interactive menu system
* Video quality selection (144p → 4K if available)
* Audio-only download with format & bitrate selection
* Feature phone optimized videos:

  * Low resolution (144p / 240p / 360p)
  * Small file size
* Automatic FFmpeg merging & conversion
* Supports:

  * MP4, MKV, WEBM
  * MP3, AAC, WAV, FLAC, OGG

---

## 📱 Feature Phone Mode

This mode is designed for:

* Button phones
* Low-end devices
* Slow internet

Settings typically include:

* H.264 video codec
* AAC audio codec
* Low bitrate
* Small resolution

---

## ⚠️ Notes

* Make sure **yt-dlp** and **ffmpeg** are accessible from command line
* Some videos may not allow certain formats
* Download speed depends on your internet connection

---

## 🛠️ Troubleshooting

**yt-dlp not recognized**

* Check PATH environment variable
* Restart PowerShell

**FFmpeg merge error**

* Ensure FFmpeg is correctly installed

**Execution policy error**

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

## 📜 Disclaimer

This project is for **educational purposes only**.
Respect YouTube's Terms of Service and local copyright laws.

---

## ⭐ Credits

* yt-dlp developers
* FFmpeg team

---

Happy Downloading 🚀
