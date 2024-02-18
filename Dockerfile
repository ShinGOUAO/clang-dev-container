FROM python:3.12.2-slim-bookworm
ENV PIP_ROOT_USER_ACTION=ignore

RUN apt-get update && apt-get install -y wget git cmake swig gnupg gnupg1 gnupg2 --no-install-recommends
RUN echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main" >> /etc/apt/sources.list && echo "deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main" >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y clang-17 lldb-17 lld-17 libc++-17-dev libc++abi-17-dev liblldb-17-dev --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/clang-17 /usr/bin/clang && ln -s /usr/bin/clang++-17 /usr/bin/clang++ \
    && ln -s /usr/bin/clang-cpp-17 /usr/bin/clang-cpp && ln -s /usr/bin/lld-17 /usr/bin/lld && ln -s /usr/bin/lldb-17 /usr/bin/lldb \
    && pip install --upgrade pip && pip install conan
CMD ["bash"]