From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 25 Apr 2011 21:21:57 +0530
Subject: [GIT PULL] DaVinci fixes for 2.6.39-rc
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CAE33C8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following DaVinci fixes for 2.6.39-rc.

Thanks,
Sekhar

The following changes since commit f0e615c3cb72b42191b558c130409335812621d8:
  Linus Torvalds (1):
        Linux 2.6.39-rc4

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git davinci-fixes

Kevin Hilman (1):
      davinci: fix DEBUG_LL code for p2v changes

Michael Williamson (2):
      davinci: mityomapl138: Use correct id for NAND controller
      davinci: mityomapl138: Use auto-probe to determine attached PHY ID

Russell King - ARM Linux (1):
      ARM: Davinci: Fix I2C build errors

Sergei Shtylyov (1):
      DA830: fix SPI1 base address

 arch/arm/mach-davinci/Kconfig                    |    6 ++++++
 arch/arm/mach-davinci/board-mityomapl138.c       |    4 ++--
 arch/arm/mach-davinci/devices-da8xx.c            |   12 +++++++++---
 arch/arm/mach-davinci/include/mach/debug-macro.S |   13 ++++++++-----
 arch/arm/mach-davinci/include/mach/serial.h      |    2 +-
 5 files changed, 26 insertions(+), 11 deletions(-)
