From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:11 +0900
Subject: [GIT PULL] Renesas ARM-based SoC boards for v3.8
Message-ID: <1350448761-27346-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 5f9f3d29d35cdf6907272e407b4fcf7eabe6b88a:

  ARM: shmobile: marzen: add HSPI support (2012-10-15 09:56:42 +0900)

----------------------------------------------------------------
Bastian Hecht (1):
      ARM: mach-shmobile: add FLCTL DMA slave definitions for sh7372

Kuninori Morimoto (5):
      ARM: shmobile: armadillo800eva: enable restart
      ARM: shmobile: r8a7779: add HSPI clock support
      ARM: shmobile: r8a7779: add I2C clock support
      ARM: shmobile: r8a7779: add I2C driver support
      ARM: shmobile: marzen: add HSPI support

Nobuhiro Iwamatsu (1):
      ARM: shmobile: r8a7740: Enable PMU

Tetsuyuki Kobayashi (3):
      ARM: shmobile: kzm9g: enable magnetometer ak8975.
      ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345
      ARM: shmobile: kzm9g: enable DMAEngine on SHDI0 and SDHI2

 arch/arm/configs/armadillo800eva_defconfig     |    1 +
 arch/arm/configs/kzm9g_defconfig               |    4 ++
 arch/arm/configs/marzen_defconfig              |    4 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 +++
 arch/arm/mach-shmobile/board-kzm9g.c           |   14 ++++-
 arch/arm/mach-shmobile/board-marzen.c          |   25 ++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c         |   16 ++++-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |    4 ++
 arch/arm/mach-shmobile/setup-r8a7740.c         |   16 +++++
 arch/arm/mach-shmobile/setup-r8a7779.c         |   77 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c          |   20 ++++++
 11 files changed, 187 insertions(+), 2 deletions(-)
