# Developer Documentation

## Environment Setup

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo apt install docker-compose -y

# Setup project
git clone <repository-url> && cd inception
for f in secrets/*.example; do cp "$f" "${f%.example}"; done
nano secrets/db_root_password.txt  # Add strong password
nano secrets/db_password.txt
nano secrets/wp_admin_password.txt
nano secrets/wp_user_password.txt
echo "127.0.0.1 mwojtcza.42.fr" | sudo tee -a /etc/hosts
```

## Project Structure

```
inception/
├── Makefile
├── secrets/
│   ├── db_root_password.txt (gitignored)
│   ├── db_password.txt (gitignored)
│   ├── wp_admin_password.txt (gitignored)
│   └── wp_user_password.txt (gitignored)
└── srcs/
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/     (Dockerfile, conf/, tools/)
        ├── wordpress/ (Dockerfile, conf/, tools/)
        └── mariadb/   (Dockerfile, conf/, tools/)
```

**Service Flow**: nginx:443 → wordpress:9000 → mariadb:3306

## Build and Launch

```bash
make              # Build and start
make build        # Build only
make down         # Stop and remove
make clean        # Clean containers
make fclean       # Full cleanup + data
make logs         # View logs
```

## Container Management

```bash
# Inspect
docker ps                           # List containers
docker inspect nginx                # Details
docker stats                        # Resource usage
docker logs -f wordpress            # Follow logs

# Execute
docker exec -it nginx bash          # Shell access
docker exec nginx nginx -t          # Test config
docker exec wordpress wp --info --allow-root
docker exec mariadb mysql -uroot -p"$(cat secrets/db_root_password.txt)"
```

## Service Details

### NGINX
- TLSv1.2/1.3 only, port 443
- SSL cert auto-generated
- Reverse proxy to wordpress:9000
- Test: `docker exec nginx nginx -t`

### WordPress
- PHP-FPM 7.4 on port 9000
- Installed via WP-CLI
- Waits for MariaDB
- Test: `docker exec wordpress wp --info --allow-root`

### MariaDB
- Database on port 3306
- Data in volume
- Creates DB + users on init
- Test: `docker exec mariadb mysqladmin ping`

## Debugging

```bash
# Check logs
docker-compose -f srcs/docker-compose.yml logs

# Test services
curl -k https://localhost:443
docker exec wordpress mysqladmin ping -hmariadb -uwpuser -p"$(cat secrets/db_password.txt)"
```

## Troubleshooting Commands

```bash
# Full system reset
make fclean && make

# Check all container health
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# View resource consumption
docker system df -v

# Clean unused resources
docker system prune -a --volumes

# Export container filesystem
docker export nginx > nginx-filesystem.tar

# Copy files from container
docker cp wordpress:/var/www/html/wp-config.php .
```
