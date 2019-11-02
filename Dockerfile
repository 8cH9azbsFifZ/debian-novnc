FROM debian:buster-slim

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT


### Envrionment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x720 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false
WORKDIR $HOME


## Prepare Debian
RUN dpkg --add-architecture i386 
RUN apt-get update
#RUN apt-get upgrade
RUN apt-get -y install wget

# Install xfce
RUN apt-get install -y supervisor xfce4 xfce4-terminal xterm
RUN apt-get purge -y pm-utils xscreensaver*
RUN apt-get clean -y
ADD ./common/xfce/ $HOME/

# Configure NoVNC
RUN apt-get -y install novnc python-websockify

# Configure custom installation scripts
ADD ./install/ $INST_SCRIPTS/

# Configure VNC
# FIXME: Use Debian version
RUN $INST_SCRIPTS/tigervnc.sh
#RUN apt-get -y install tigervnc-standalone-server


# Startup Scripts
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./common/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

# set user to 1000 - further installations with user 0
USER 1000

# Startup
ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["/usr/bin/xeyes"]

