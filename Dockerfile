FROM quay.io/uninuvola/base:main

# DO NOT EDIT USER VALUE
USER root

## -- ADD YOUR CODE HERE !! -- ##
RUN apt update && \
    apt install -y zip unzip unrar-free openssh-client htop procps nano less tmux screen vim curl git gfortran rsync ristretto cmake build-essential gnuplot

# Firefox
RUN install -d -m 0755 /etc/apt/keyrings && \
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null && \
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null && \
    echo -e "Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n" | tee /etc/apt/preferences.d/mozilla && cat /etc/apt/preferences.d/mozilla && \
    apt-get update && apt-get install -y firefox

# VSCodium (https://github.com/VSCodium/vscodium/releases/latest)
RUN wget -O codium.deb https://github.com/VSCodium/vscodium/releases/download/1.98.2.25078/codium_1.98.2.25078_amd64.deb && \
    apt-get -y install ./codium.deb

RUN echo "exec /bin/bash" >> /etc/profile && \
    echo "for i in jpeg png gif bmp webp tiff; do xdg-mime default org.xfce.ristretto.desktop image/\$i;done" >> /etc/profile.d/ristretto.sh 

USER jovyan
