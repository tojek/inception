# Inception

*This project has been created as part of the 42 curriculum by mwojtcza.*

## Description

A Docker-based infrastructure with NGINX, WordPress, and MariaDB running in separate containers. Each service is configured from scratch using custom Dockerfiles, with proper networking, volumes, and security.

## Instructions

### Setup

1. Add to `/etc/hosts`: `127.0.0.1 mwojtcza.42.fr`
2. Copy environment file: `cp srcs/.env.example srcs/.env`
3. Edit `srcs/.env` with your credentials
4. Run: `make`

### Access

- Website: https://mwojtcza.42.fr
- Admin: https://mwojtcza.42.fr/wp-admin

### Commands

- `make` - Build and start
- `make down` - Stop services
- `make clean` - Remove containers
- `make fclean` - Full cleanup
- `make logs` - View logs

## Project Description

### Services

- **NGINX**: TLSv1.2/1.3, port 443 only
- **WordPress**: PHP-FPM 7.4
- **MariaDB**: Database server with persistent storage

### Docker Comparisons

**Virtual Machines vs Docker**
- VMs: Full OS, heavy, slow startup
- Docker: Shared kernel, lightweight, fast

**Secrets vs Environment Variables**
- Env vars: Simple, visible in inspect
- Secrets: Encrypted, secure storage

**Docker Network vs Host Network**
- Docker Network: Isolated, service discovery
- Host Network: Direct host stack access

**Docker Volumes vs Bind Mounts**
- Volumes: Docker-managed storage
- Bind Mounts: Direct host path mapping

### Technical Details

- Base: Debian Bullseye (stable, compatible)
- Network: Bridge network with DNS resolution
- Data: Persisted in `/home/${USER}/data/`
- Security: SSL/TLS, no passwords in files, .env gitignored

## Resources

- [Docker Docs](https://docs.docker.com/) | [Compose](https://docs.docker.com/compose/)
- [NGINX](https://nginx.org/en/docs/) | [WordPress](https://wordpress.org/documentation/) | [MariaDB](https://mariadb.com/kb/)

