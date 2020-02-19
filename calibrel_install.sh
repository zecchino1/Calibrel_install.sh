# To make this file executable chmod +x <filename>

echo "Installing dependencies"
sudo yum check-update
sudo yum -y install wget make gcc-c++

echo "Downloading gcc new version"
wget -O - 'https://ftpmirror.gnu.org/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz' | tar -xJ

# This helps if you are behind a proxy (uncomment if needed)
# sed -i 's/ftp:/https:/' ./gcc-7.3.0/contrib/download_prerequisites

echo "compiling gcc" 
( cd gcc-7.3.0 && ./contrib/download_prerequisites && mkdir build && cd build && ../configure --enable-checking=release --enable-languages=c,c++ --disable-multilib && make -j 8 && sudo make install ) && rm -fR gcc-7.3.0

echo "Unlinking current version"
sudo unlink /usr/lib64/libstdc++.so.6

echo "Copying new version"
sudo cp /usr/local/lib64/libstdc++.so.6 /usr/lib64

echo "Installing calibrel"
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
