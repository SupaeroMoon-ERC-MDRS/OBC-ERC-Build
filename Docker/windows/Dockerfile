FROM --platform=$BUILDPLATFORM mcr.microsoft.com/windows/servercore:ltsc2022

ARG TARGETARCH
ARG BUILDPLATFORM
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Install Chocolatey
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install dependencies based on architecture
RUN IF "%TARGETARCH%"=="arm64" ( \
        choco install -y msys2 --params "/NoUpdate /InstallDir:C:\msys64" && \
        C:\msys64\usr\bin\bash -lc "pacman -S --noconfirm mingw-w64-aarch64-toolchain" \
    ) ELSE ( \
        choco install -y msys2 --params "/NoUpdate /InstallDir:C:\msys64" && \
        C:\msys64\usr\bin\bash -lc "pacman -S --noconfirm mingw-w64-x86_64-toolchain" \
    )

# Windows-specific dependencies
RUN apt-get update && apt-get install -y \
    wine64 \
    mingw-w64 \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV WINEARCH=win64

COPY --from=base . .