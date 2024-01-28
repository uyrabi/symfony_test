FROM php:5.3-apache

RUN echo "deb http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update -y --force-yes && \
    apt-get upgrade -y --force-yes && \
    apt-get install -y --force-yes wget vim && \
    cd /var/www/html && \
    mkdir -p sf14/lib/vendor && \
    echo "hogehogehoge---" && \
    cd sf14/lib/vendor && \
    # wget http://www.symfony-project.org/get/symfony-1.4.9.tgz && \
    # tar zxvf symfony-1.4.9.tgz && \
    # mv symfony-1.4.9 symfony && \
    # rm symfony-1.4.9.tgz
    wget https://src.fedoraproject.org/repo/pkgs/php-symfony-symfony/symfony-1.4.8.tgz/md5/877687bae0f01fd7bd5727c030b8b275/symfony-1.4.8.tgz && \
    tar zxvf symfony-1.4.8.tgz && \
    mv symfony-1.4.8 symfony && \
    rm symfony-1.4.8.tgz && \
    mkdir -p /var/lock/apache2 && chown -R www-data:www-data /var/lock/apache2 && \
    mkdir -p /var/run/apache2 && chown -R www-data:www-data /var/run/apache2 && \
    cd /var/www/html && \
    a2enmod rewrite && \
    cd /var/www/html/sf14 && \
    php lib/vendor/symfony/data/bin/symfony generate:project sf14 && \
    php symfony generate:app frontend && \
    ln -s /var/www/html/sf14/lib/vendor/symfony/data/web/sf/ 
    ##  docker-composeのvolume用にコンテナ上のプロジェクトをローカルにコピーする
    # docker cp <Container ID>:/var/www/html/sf14/ ./backup