From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 22 Mar 2013 00:13:31 -0700 (PDT)
Subject: [PATCH 0/3] ARM: shmobile: Add SMSC support on Bock-W
Message-ID: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Simon, Magnus

These patch set add extpin support on r8a7778,
and enable SMSC ether on Bock-W board

This patch set is based on simon/next + my previous Bock-W patch set

Kuninori Morimoto (3):
      ARM: shmobile: define PLATFORM_xxx_INFO()
      ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
      ARM: shmobile: bockw: add SMSC ethernet support

 arch/arm/boot/dts/r8a7778-bockw.dts           |    2 +-
 arch/arm/configs/bockw_defconfig              |   34 ++++++++-
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/board-bockw.c          |   37 ++++++++++
 arch/arm/mach-shmobile/include/mach/common.h  |   20 ++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   92 +++++++++++++++++--------
 7 files changed, 156 insertions(+), 31 deletions(-)


Best regards
---
Kuninori Morimoto
