# =====================================================
# YT-DLP POWER DOWNLOADER PROJECT (ADVANCED)
# Playlist + Resume + Progress
# Author: Mohammod Mizanur Rahman 
# =====================================================

#region CONFIG
$Global:DOWNLOAD_PATH = "E:\MyDownloads\YT"
$Global:YTDLP = "yt-dlp"
#endregion

#region INIT
if (!(Test-Path $DOWNLOAD_PATH)) {
    New-Item -ItemType Directory -Path $DOWNLOAD_PATH | Out-Null
}

if (!(Get-Command $YTDLP -ErrorAction SilentlyContinue)) {
    Write-Host "[-] yt-dlp not found!" -ForegroundColor Red
    exit
}
#endregion

#region UTIL
function Pause { Write-Host "[+] Save Path: $DownloadLocation " -ForegroundColor Gray }

function Ask-URL {
    do {
        $url = Read-Host "`n[+] Enter Video / Playlist URL"
    } while ([string]::IsNullOrWhiteSpace($url))
    return $url
}

function Ask-Playlist {
    Clear-Host
    Write-Host "[+] Download Mode`n"
    Write-Host "1. Single Video"
    Write-Host "2. Playlist`n"
    switch (Read-Host "[+] Select (1/2)" ) {
        "1" { return "--no-playlist" }
        "2" { return "--yes-playlist" }
        default { return "--no-playlist" }
    }
}

function Common-Args {
    return @(
        "-c",                               # Resume
        "--newline",
        "--progress",
        "--concurrent-fragments", "8",
        "--restrict-filenames"
    )
}
#endregion

#region AUDIO
function Audio-Menu {
    Clear-Host
    Write-Host "[=== AUDIO DOWNLOAD ===]" -ForegroundColor Cyan
    Write-Host "1. Top lovel Mp3"
    Write-Host "2. High (MP3 128kbps)"
    Write-Host "3. Medium (MP3 96kbps)"
    Write-Host "4. Low / Button Phone (MP3 64kbps)"
    Write-Host "0. Back"

    switch (Read-Host "[+] Select (1-2)") {

        "1" { Download-Audio "0" }
        "2" { Download-Audio "5" }
        "3" { Download-Audio "7" }
        "4" { Download-Audio "9" }
        "0" { Main-Menu }
        default { Audio-Menu }
    }
}

function Download-Audio ($aq) {
    $url = Ask-URL
    $playlist = Ask-Playlist

    yt-dlp `
        -x `
        --audio-format mp3 `
        --audio-quality $aq `
        --embed-thumbnail `
        --add-metadata `
        $playlist `
        (Common-Args) `
        -o "$DOWNLOAD_PATH\%(playlist_title,NA)s\%(title)s.mp3" `
        $url

    Main-Menu
}
#endregion

#region VIDEO
function Video-Menu {
    Clear-Host
    Write-Host "`n[=== VIDEO DOWNLOAD ===]`n" -ForegroundColor Green
    Write-Host "1. Best  MKV"
    Write-Host "2. 1080p MP4"
    Write-Host "3. 720p  MP4"
    Write-Host "4. 480p  MP4"
    Write-Host "5. 360p  MP4"
    Write-Host "6. 240p  MP4"
    Write-Host "0. Back  MP4"

    switch (Read-Host "`n[+] Select (1-5)") {
        "1" { Download-Video "bv+ba/b" "best" }
        "2" { Download-Video "bv*[height<=1080][ext=mp4]+ba/b" "1080p" }
        "3" { Download-Video "bv*[height<=7200][ext=mp4]+ba/b" "720p" }
        "4" { Download-Video "bv*[height<=480][ext=mp4]+ba/b" "480p" }
        "5" { Download-Video "bv*[height<=360][ext=mp4]+ba/b" "360p" }
        "6" { Download-Video "bv*[height<=240][ext=mp4]+ba/b" "240p" }
        "0" { Video-Menu }
        default { Main-Menu }
    }
}

function Download-Video ($format, $label) {
    $url = Ask-URL
    $playlist = Ask-Playlist

    if ($label -eq "best") {
        yt-dlp `
        -f $format `
        --merge-output-format mkv `
        $playlist `
        (Common-Args) `
        -o "$DOWNLOAD_PATH\%(playlist_title,NA)s\%(title)s_$label.mp4" `
        $url

    }
    else {
        yt-dlp `
        -f $format `
        --merge-output-format mp4 `
        $playlist `
        (Common-Args) `
        -o "$DOWNLOAD_PATH\%(playlist_title,NA)s\%(title)s_$label.mp4" `
        $url

    }

    Main-Menu

}
#endregion

#region FEATURE PHONE
function FeaturePhone-Menu {
    Clear-Host
    Write-Host "`n[=== FEATURE / BUTTON PHONE ===]`n" -ForegroundColor Yellow
    Write-Host "1. 3GP (144p)"
    Write-Host "2. MP4 (240p)"
    Write-Host "3. MP4 (360p)"
    Write-Host "0. Back"

    switch (Read-Host "`n[+] Select (1-3)") {
        "1" { Feature-Download 144 "3gp" }
        "2" { Feature-Download 240 "mp4" }
        "3" { Feature-Download 360 "mp4" }
        "0" { Main-Menu }
        default { FeaturePhone-Menu }
    }
}

function Feature-Download ($height, $type) {
    $url = Ask-URL
    $playlist = Ask-Playlist

    if ($type -eq "3gp") {
        yt-dlp `
            -f "best" `
            --postprocessor-args "ffmpeg:-vcodec h264 -acodec aac -s 320x240 -aspect 4:3" `
            --merge-output-format 3gp `
             $playlist `
            (Common-Args) `
            -o "$DOWNLOAD_PATH\%(playlist_title,NA)s\%(title)s_LBM.3gp" `
            $url

    }
    else {
        yt-dlp `
            -f "bv*[height<=360][ext=mp4]+ba/b" `
            --postprocessor-args "ffmpeg:-vcodec h264 -acodec aac -s 320x240 -aspect 4:3" `
            --merge-output-format mp4 `
             $playlist `
            (Common-Args) `
            -o "$DOWNLOAD_PATH\%(playlist_title,NA)s\%(title)s_BM.mp4" `
            $url

    }

    Main-Menu
}
#endregion

#region MAIN MENU
function Main-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   ***********************************       " -ForegroundColor Gray
    Write-Host "      YouTube Downloader Pro (v2)       " -ForegroundColor Green
    Write-Host "    Author: Mohammod Mizanur Rahman       " -ForegroundColor Red
    Write-Host "   ***********************************       `n" -ForegroundColor Gray
    Write-Host "========================================`n`n" -ForegroundColor Green


    Write-Host "[+] Select YouTube Downloader Tipe" -ForegroundColor Green
    Write-Host "1. Video Download"
    Write-Host "2. Audio Download"
    Write-Host "3. Feature / Button Phone"
    Write-Host "0. Exit`n"

    switch (Read-Host "[+] Select (1-3)") {
        "1" { Video-Menu }
        "2" { Audio-Menu }
        "3" { FeaturePhone-Menu }
        "0" { exit }
        default { Main-Menu }
    }
}
#endregion

Main-Menu
