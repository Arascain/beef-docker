# BeEF Docker Release 2025 - Red Team Stable

---

## 🇫🇷 Description

Image Docker ultra-stable pour installer BeEF sur Kali/Debian modernes sans conflit Ruby/SSL.

- Debian Bullseye
- Ruby 2.7.8 compilé manuellement
- BeEF v0.5.0.0 (stable Ruby 2.7)
- Bundler 2.3.27
- Dépendances curb fixées

---

git clone https://github.com/Arascain/beef-docker.git
cd beef-docker
podman-compose up --build


## 🇫🇷 Build :

bash :
    podman build -t beef-kali2025 .

Mode interactif (pour debug / dev) :
    podman run -it -p 3000:3000 beef-kali2025

Mode détaché (prod / lab) :
    podman run -d --name beef-pro -p 3000:3000 beef-kali2025



## 🇫🇷 Run :
podman run -it -p 3000:3000 beef-kali2025
podman run -d --name beef-pro -p 3000:3000 beef-kali2025


Et accéder à :
http://localhost:3000/ui/panel

    # Credentials to authenticate in BeEF.
    # Used by both the RESTful API and the Admin interface
    credentials:
        user:   "beef"
        passwd: "ChangeMe123!"

podman exec -it e5238377fdca cat /opt/beef/config.yaml 

## 🇬🇧 Description

Ultra-stable Docker image for BeEF deployment on modern Kali/Debian without Ruby/SSL conflicts.

- Debian Bullseye
- Ruby 2.7.8 manually compiled
- BeEF v0.5.0.0 (stable Ruby 2.7)
- Bundler 2.3.27
- Curb dependencies fixed

---


## 🇬🇧 Build :

bash
podman build -t beef-kali2025 .


## 🇬🇧 Run :
podman run -it -p 3000:3000 beef-kali2025
podman run -d --name beef-pro -p 3000:3000 beef-kali2025



Access to :
http://localhost:3000/ui/panel

    # Credentials to authenticate in BeEF.
    # Used by both the RESTful API and the Admin interface
    credentials:
        user:   "beef"
        passwd: "ChangeMe123!"

podman exec -it e5238377fdca cat /opt/beef/config.yaml 

