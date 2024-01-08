### 임시 메모장<br>

amazon linux 2에서 nvim을 설치하기 위해 `cmake`는 3 이상의 버전이 필요

----
#### Step 1. install packages
```
sudo yum install "Development tools"
sudo yum install openssl-devel
sudo yum install gcc-c++ python3-pip
```

#### Step 2. wget cmake && Extract cmake
```
cd "$(mktemp -d)"
wget cmake-3.28.1.tar.gz
```

#### Step 3. Install cmake
```
cd cmake-3.28.1
./bootstrap
make
sudo make install
```

#### Step 4. Install Neovim <b>9버전으로 설치 필요!!</b>
```
sudo pip3 install neovim --upgrade

cd "$(mktemp -d)"
git clone -b v0.9.5 https://github.com/neovim/neovim.git

cd neovim

make CMAKE_BUILD_TYPE=Release

make install

```