# Secrets Setup Instructions

This project uses Docker secrets to securely manage sensitive credentials.

## Quick Setup

1. Copy the example files and remove the `.example` extension:
   ```bash
   cd secrets
   cp db_root_password.txt.example db_root_password.txt
   cp db_password.txt.example db_password.txt
   cp wp_admin_password.txt.example wp_admin_password.txt
   cp wp_user_password.txt.example wp_user_password.txt
   ```

2. Edit each file with strong, unique passwords:
   ```bash
   nano db_root_password.txt
   nano db_password.txt
   nano wp_admin_password.txt
   nano wp_user_password.txt
   ```

3. Secure the files:
   ```bash
   chmod 600 *.txt
   ```

## Example Strong Password

```
Xk9#mP2@vL5$nQ8!
```

Generate random passwords with:
```bash
openssl rand -base64 16
```
