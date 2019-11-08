#!/bin/sh

if [ -f /var/www/html/lib/Zend/Mail/Protocol/Smtp.php ]; then
    sed -i "s/_send('EHLO .*$/_send('HELO $EHLO_HELO_DOMAIN')\;/" /var/www/html/lib/Zend/Mail/Protocol/Smtp.php
    sed -i "s/_send('HELO .*$/_send('HELO $EHLO_HELO_DOMAIN')\;/" /var/www/html/lib/Zend/Mail/Protocol/Smtp.php
fi

# Start the ssh server
/etc/init.d/ssh start && /sbin/my_init

# Execute the CMD
# exec "$@"
