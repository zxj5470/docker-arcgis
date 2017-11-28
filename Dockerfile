FROM centos:6.7

MAINTAINER @zxj5470 <zxj5470@foxmail.com>

RUN yum -y --nogpg install xorg-x11-server-Xvfb fontconfig freetype gettext less htop vim redhat-lsb 

RUN mkdir /arcgis
ADD server.ecp /arcgis/
ADD ArcGIS_Server_10_2.tar.gz /arcgis/

ENV USER arcgis
ENV GROUP arcgis

RUN groupadd $GROUP
RUN useradd -m -r $USER -g $GROUP

RUN mkdir -p /arcgis/server
RUN chown -R $USER:$GROUP /arcgis
RUN chmod -R 755 /arcgis

EXPOSE 6080 6443 4001 4002 4004 6600 6601 6602 6603

USER $USER

RUN /arcgis/ArcGISServer/ArcGISServer/Setup -m silent -l yes -a /arcgis/server.ecp -d /

ENTRYPOINT /arcgis/server/startserver.sh && /bin/bash
