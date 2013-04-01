From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 31 Mar 2013 19:25:39 -0700 (PDT)
Subject: [PATCH 0/3 v2] ARM: shmobile: Add SMSC support on Bock-W
In-Reply-To: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Simon, Magnus

These patches are v2 of extpin support on r8a7778,
and enable SMSC ether support on Bock-W board

This patch set is based latest simon/next

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
      ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
      ARM: shmobile: bockw: add SMSC ethernet support

 arch/arm/boot/dts/r8a7778-bockw.dts           |    2 +-
 arch/arm/configs/bockw_defconfig              |   34 ++++++++++--
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/board-bockw.c          |   38 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   70 +++++++++++++++++++------
 6 files changed, 125 insertions(+), 21 deletions(-)

Best regards
---
Kuninori Morimoto
