From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 12:09:10 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq changes for v3.8
Message-ID: <CAHTX3dLdGie9gtxbPq_gb8BLao7YYohqQWZFg3LzyNHxu=imdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please add these patches to your arm-soc trees. All these patches are
for xilinx zynq arm platform.
You shouldn't have any problem to merge it there are no conficts with v3.7-rc4.

Please let me know if you find out any problem.

Thanks,
Michal

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
  Linus Torvalds (1):
        Linux 3.7-rc3

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git arm-next

Josh Cartwright (4):
      zynq: use GIC device tree bindings
      zynq: use pl310 device tree bindings
      zynq: remove use of CLKDEV_LOOKUP
      zynq: move static peripheral mappings

 arch/arm/Kconfig                           |    1 -
 arch/arm/Makefile                          |    1 -
 arch/arm/boot/dts/zynq-ep107.dts           |   19 +++++++++++++---
 arch/arm/mach-zynq/common.c                |   23 ++++++++-----------
 arch/arm/mach-zynq/include/mach/clkdev.h   |   32 ----------------------------
 arch/arm/mach-zynq/include/mach/zynq_soc.h |   31 +++++++++++++--------------
 6 files changed, 40 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h
