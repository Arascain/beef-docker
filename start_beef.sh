#!/bin/bash

# Build de l'image docker
docker build -t beef-kali2025 .

# Lancement de BeEF
docker run -it --rm -p 3000:3000 beef-kali2025

