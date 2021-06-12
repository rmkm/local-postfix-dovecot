# local-postfix-dovecot
SMTP and POP3 mail server for local network and testing

# Feature
- The container publishes port 25(SMTP) and 110(POP3)
- No IPv6
- Plain text auth for POP3
- No SSL

# Install
1. `git clone https://github.com/rmkm/local-postfix-dovecot.git`
1. Modify ```main.cf``` and add your local domain  
mydestination = $myhostname, localhost.$mydomain, localhost, **example.local** #(add)
1. Run `run.sh` to build the image and run the container
1. Add email accounts  
`docker exec -it mypostfix useradd user1`
1. Set password  
`docker exec -it mypostfix passwd user1`
1. Configure email client
    | Item | Setting |
    | :----: | :----: |
    | SMTP/POP3 server | The host this container is running |
    | SSL | None |
    | Authentication | Normal password |
    | Username | user1 |
    
    Check if you can send email  
    from: `user1@example.local`  
    to: `user1@example.local`  
    any title and body text  

# Commands
- List all non-default users  
`docker exec mypostfix awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd`
- Delete a user  
`docker exec mypostfix userdel -r [username]`
