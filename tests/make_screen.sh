./configure --prefix=/usr                     \
            --infodir=/usr/share/info         \
            --mandir=/usr/share/man           \
            --with-socket-dir=/run/screen     \
            --with-pty-group=5                \
            --with-sys-screenrc=/etc/screenrc

sed -i -e "s%/usr/local/etc/screenrc%/etc/screenrc%" {etc,doc}/*

make

make install

install -m 644 etc/etcscreenrc /etc/screenrc