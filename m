From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 18:27:41 +0200
Subject: [PATCH 0/6] ARM: shmobile: r8a7740: add MMCIF and SDHI to DT
Message-ID: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add DT support for MMCIF and SDHI including DMA on 
armadillo800eva-reference r8a7740 board. They require my previous 
SHDMA DT and SDHI and MMCIF DMA patches.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  ARM: shmobile: armadillo800eva: remove left-overs
  ARM: shmobile: add SDHI and MMCIF interfaces to
    armadillo800eva-reference
  ARM: shmobile: sh73a0: remove "0x" prefix from DT node names
  ARM: shmobile: r8a7740: add MMCIF DMA definitions
  ARM: shmobile: r8a7740: add DT node for one DMAC instance
  ARM: shmobile: armadillo800eva-reference: add DMA support for MMCIF
    and SDHI

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   30 +++++++++++-
 arch/arm/boot/dts/r8a7740.dtsi                     |   53 ++++++++++++++++++++
 arch/arm/boot/dts/sh73a0.dtsi                      |   18 +++---
 .../board-armadillo800eva-reference.c              |   36 +++++++++++++-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    9 ---
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |    2 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |   12 +++++
 7 files changed, 140 insertions(+), 20 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
