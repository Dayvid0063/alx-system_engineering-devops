# Install Nginx package via puppet

# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx is listening on port 80
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html index.htm index.nginx-debian.html;

      location / {
        try_files \$uri \$uri/ =404;
        add_header Content-Type text/html;
        echo 'Hello World!';
      }

      location = /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
      }
    }
  ",
  require => Package['nginx'],
}

# Activate the default Nginx configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
}

# Restart Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => [File['/etc/nginx/sites-available/default'], Package['nginx']],
}
