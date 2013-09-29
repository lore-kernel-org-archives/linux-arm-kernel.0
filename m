From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 21:29:16 +0800
Subject: [GIT PULL]ARM: sirf: dts fixes for 3.12-rc
Message-ID: <CAGsJ_4yfNE3NMvf9jkyaZM84i9zdEM3wm=VgFPamKT_F33Lo2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/dts-fixes-for-3.12

for you to fetch changes up to 65dc961989ba0f4dc57d614a9af43c19460204dd:

  ARM: dts: sirf: fix interrupt and dma prop of VIP for prima2 and
atlas6 (2013-09-29 21:08:06 +0800)

----------------------------------------------------------------
ARM: sirf: dts fixes for 3.12-rc

A set of fixes for sirf dts for 3.12. Among them:
  - add missed chhifbg node in prima2 and atlas6 dts
  - add missed cell, cs and dma channel for SPI nodes
  - add missed graphics2d iobg in atlas6 dts
  - add missed address-cells and size-cells for prima2 I2C
  - add missed memcontrol-monitor node in prima2 and atlas6 dts
  - fix makefile to build atlas6-evb.dtb for ARCH_ATLAS6
  - fix the ranges of peri-iobrg of prima2
  - fix fifosize, clks, dma channels for UART
  - fix interrupt and dma prop of VIP for prima2 and atlas6

----------------------------------------------------------------
Barry Song (4):
      ARM: dts: sirf: add missed chhifbg node in prima2 and atlas6 dts
      ARM: dts: sirf: add missed cell, cs and dma channel for SPI nodes
      ARM: dts: makefile: build atlas6-evb.dtb for ARCH_ATLAS6
      ARM: dts: sirf: fix the ranges of peri-iobrg of prima2

Jiansong Chen (1):
      ARM: dts: sirf: add missed graphics2d iobg in atlas6 dts

Qipan Li (1):
      ARM: dts: sirf: fix fifosize, clks, dma channels for UART

Renwei Wu (2):
      ARM: dts: sirf: add missed address-cells and size-cells for prima2 I2C
      ARM: dts: sirf: fix interrupt and dma prop of VIP for prima2 and atlas6

Ye He (1):
      ARM: dts: sirf: add missed memcontrol-monitor node in prima2 and
atlas6 dts

 arch/arm/boot/dts/Makefile    |  2 ++
 arch/arm/boot/dts/atlas6.dtsi | 45 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/prima2.dtsi | 57 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 98 insertions(+), 6 deletions(-)
