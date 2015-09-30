From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 Sep 2015 17:50:17 +0200
Subject: [PATCH 0/3] ARM: shmobile: Misc Cleanups
Message-ID: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series contains a few cleanups.

Geert Uytterhoeven (3):
  ARM: shmobile: smp: Make shmobile_smp_apmu_cpu_shutdown() static
  ARM: shmobile: r8a7778: Make r8a7778_init_irq_dt() static
  ARM: shmobile: r8a7779: Remove legacy PM Domain remainings

 arch/arm/mach-shmobile/platsmp-apmu.c  |  2 +-
 arch/arm/mach-shmobile/pm-r8a7779.c    | 99 ----------------------------------
 arch/arm/mach-shmobile/r8a7779.h       |  6 ---
 arch/arm/mach-shmobile/setup-r8a7778.c |  3 +-
 4 files changed, 3 insertions(+), 107 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
