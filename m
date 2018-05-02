From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 2 May 2018 20:24:54 +0530
Subject: [GIT PULL] DaVinci fixes for v4.17
Message-ID: <8a5aef77-d983-03a4-6387-31f4e6fd0bb7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.17

for you to fetch changes up to 9411ac07cd764be34bbd7ff09125a6b7b9175d4c:

  ARM: davinci: fix GPIO lookup for I2C (2018-05-02 14:55:06 +0530)

----------------------------------------------------------------
DaVinci fixes for v4.17
* W=1 warning fixes in device-tree files
* GPIO look-up fixes for legacy boot on several platforms

----------------------------------------------------------------
Sekhar Nori (8):
      ARM: dts: da850: get rid of skeleton.dtsi
      ARM: dts: da850-lcdk: add unit name for memory node
      ARM: dts: da850: fix W=1 warnings with pinmux node
      ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup
      ARM: davinci: board-dm355-evm: fix broken networking
      ARM: davinci: fix GPIO lookup for I2C

 arch/arm/boot/dts/da850-lcdk.dts            |  4 ++--
 arch/arm/boot/dts/da850.dtsi                | 13 ++++++++++---
 arch/arm/mach-davinci/board-da830-evm.c     |  9 +++++++--
 arch/arm/mach-davinci/board-da850-evm.c     |  9 +++++++--
 arch/arm/mach-davinci/board-dm355-evm.c     | 15 ++++++++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c    | 10 +++++++---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 +++++++---
 7 files changed, 52 insertions(+), 18 deletions(-)
