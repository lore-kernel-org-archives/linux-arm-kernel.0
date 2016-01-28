From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:13:29 +0100
Subject: [PATCH 0/3] ARM: shmobile: SCU cleanup and consolidation
Message-ID: <1453994012-12696-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Magnus, Simon,

This patch series contains cleanups and consolidations of the SCU code
for shmobile SoCs with Cortex-A9 CPU cores.

This has been tested on emev2/kzm9d, r8a7779/marzen, and sh73a0/kzm9g.

Thanks!

Geert Uytterhoeven (3):
  ARM: shmobile: Typo s/MIPDR/MPIDR/
  ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup
    code
  ARM: shmobile: Consolidate SCU mapping code

 arch/arm/mach-shmobile/common.h      |  5 ++---
 arch/arm/mach-shmobile/headsmp-scu.S |  2 +-
 arch/arm/mach-shmobile/platsmp-scu.c | 10 +++++++---
 arch/arm/mach-shmobile/smp-emev2.c   |  3 +--
 arch/arm/mach-shmobile/smp-r8a7779.c |  5 +----
 arch/arm/mach-shmobile/smp-sh73a0.c  |  3 +--
 6 files changed, 13 insertions(+), 15 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
