cd /etc/apache2/sites-available

read -p "Enter config name: " name
read -p "Enter port number: " port
read -p "Enter full path: " path

sudo rm /etc/apache2/sites-available/$name.conf /etc/apache2/sites-enabled/$name.conf

sudo touch "$name.conf"

content="Listen $port \n
 <VirtualHost *:$port>\n
    DocumentRoot $path \n
    <Directory $path> \n
        Options Indexes FollowSymLinks MultiViews \n
        AllowOverride All \n
    </Directory> \n
</VirtualHost>"

echo "$content" | sudo tee $name.conf

sudo a2ensite "$name.conf"

sudo service apache2 restart
