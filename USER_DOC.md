# User Documentation

## Overview

Three Docker services provide a complete WordPress hosting stack:
- **NGINX**: Web server with HTTPS (port 443)
- **WordPress**: Content management system
- **MariaDB**: Database server

## Setup

1. Add to `/etc/hosts`:
   ```bash
   sudo nano /etc/hosts
   # Add: 127.0.0.1 mwojtcza.42.fr
   ```

2. Configure environment:
   ```bash
   cp srcs/.env.example srcs/.env
   nano srcs/.env  # Add your passwords
   ```

## Starting and Stopping

```bash
make           # Start all services
make stop      # Stop (keeps data)
make down      # Stop and remove containers
make status    # Check status
make logs      # View logs
```

## Access

- **Website**: https://mwojtcza.42.fr
- **Admin Panel**: https://mwojtcza.42.fr/wp-admin
- **Admin User**: mwojtcza (see `.env` for password)
- **Regular User**: user (see `.env` for password)

*Accept the self-signed SSL certificate warning in your browser.*

## Credentials

All credentials are in `srcs/.env`:
- `WORDPRESS_ADMIN_PASSWORD` - Admin access
- `WORDPRESS_USER_PASSWORD` - Regular user
- `MYSQL_ROOT_PASSWORD` - Database root
- `MYSQL_PASSWORD` - WordPress database user

**Security**: Never commit `.env` to git. Use `chmod 600 srcs/.env` to restrict access.

## Checking Services

```bash
make status                    # Container status
docker logs nginx              # NGINX logs
docker logs wordpress          # WordPress logs
docker logs mariadb            # Database logs
curl -k https://mwojtcza.42.fr # Test connection
```

## Troubleshooting

**Services won't start**
```bash
make logs                      # Check errors
sudo netstat -tlnp | grep :443 # Check port 443
```

**Can't access website**
```bash
cat /etc/hosts | grep mwojtcza # Verify domain
make status                     # Check containers running
```

**Database errors**
```bash
docker logs mariadb            # Check database logs
```
