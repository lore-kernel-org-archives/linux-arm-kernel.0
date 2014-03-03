From: xbing6@gmail.com (Xuebing wang)
Date: Mon, 03 Mar 2014 17:28:41 +0800
Subject: [Qemu-devel] Using qemu to debug arm64 linux kernel
Message-ID: <53144B49.8010407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi community,

I can think of 2 ways to use gdb+qemu to remotely debug arm64 kernel, by 
enabling gdbstub within qemu to communicate with gdb.

I am wondering in the real-world practice, is this debug technique 
helpful for debugging arm64 kernel?

Options are:

1) Host environment: qemu is running as kvm hypervisor

i) armv8 foundation model running arm64 kernel
ii) or a real armv8 Linux machine running arm64 kernel

Qemu guest environment: arm64 kernel

2) Host environment: x86 linux machine running qemu as tcg aarch64 emulator

Qemu guest environment: arm64 kernel

Prerequisite: qemu-aarch64 needs to be reliable.

-- Thanks,
Xuebing Wang
