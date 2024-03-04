# Install,Config with a custom header and Start Nginx

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Server configuration
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files \$uri \$uri/ =404;
        add_header X-Served-By \$hostname;
    }
    if (\$request_filename ~ redirect_me){
        rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
    }
    error_page 404 /404.html;
    location = /404.html {
        root /var/www/error/;
        internal;
        add_header X-Served-By \$hostname;
    }
}",
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
}
