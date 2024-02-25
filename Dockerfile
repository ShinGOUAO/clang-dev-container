FROM python:3.12.2-slim-bookworm
ENV PIP_ROOT_USER_ACTION=ignore

RUN apt update && apt install -y curl git ninja-build cmake swig gnupg --no-install-recommends
RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /etc/apt/keyrings/llvm.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/llvm.gpg] http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main" | tee /etc/apt/sources.list.d/llvm.list > /dev/nul
RUN apt update && apt install -y clang-17 lldb-17 lld-17 libc++-17-dev libc++abi-17-dev liblldb-17-dev --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/clang-17 /usr/bin/clang && ln -s /usr/bin/clang++-17 /usr/bin/clang++ \
    && ln -s /usr/bin/clang-cpp-17 /usr/bin/clang-cpp && ln -s /usr/bin/lld-17 /usr/bin/lld && ln -s /usr/bin/lldb-17 /usr/bin/lldb \
    && pip install --upgrade pip && pip install conan
CMD ["bash"]