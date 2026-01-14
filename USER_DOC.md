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

2. Configure secrets:
   ```bash
   cd secrets
   cp db_root_password.txt.example db_root_password.txt
   cp db_password.txt.example db_password.txt
   cp wp_admin_password.txt.example wp_admin_password.txt
   cp wp_user_password.txt.example wp_user_password.txt
   # Edit each file with strong passwords
   nano db_root_password.txt
   nano db_password.txt
   nano wp_admin_password.txt
   nano wp_user_password.txt
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
- **Admin User**: mwojtcza (see `secrets/wp_admin_password.txt`)
- **Regular User**: user (see `secrets/wp_user_password.txt`)

*Accept the self-signed SSL certificate warning in your browser.*

## Credentials

All credentials are stored in `secrets/` directory:
- `wp_admin_password.txt` - Admin access
- `wp_user_password.txt` - Regular user
- `db_root_password.txt` - Database root
- `db_password.txt` - WordPress database user

**Security**: Never commit `secrets/*.txt` files to git. Use `chmod 600 secrets/*.txt` to restrict access.

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
