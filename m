From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  9 Feb 2017 11:18:47 +0100
Subject: [PATCH 0/2] ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
Message-ID: <1486635529-6636-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series completes the migration from ARCH_SHMOBILE_MULTI to
ARCH_RENESAS, which was started by commit 9b5ba0df4ea4 ("ARM: shmobile:
Introduce ARCH_RENESAS").

Thanks for applying!

Geert Uytterhoeven (2):
  ARM: dts: renesas: Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
  ARM: shmobile: Remove ARCH_SHMOBILE_MULTI

 arch/arm/boot/dts/Makefile     | 38 +++++++++++++++++++-------------------
 arch/arm/mach-shmobile/Kconfig |  4 ----
 2 files changed, 19 insertions(+), 23 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
