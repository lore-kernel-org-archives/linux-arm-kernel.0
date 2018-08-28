From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 17:10:09 +0200
Subject: [PATCH v2 0/2] arm: renesas: Remove the ARCH_SHMOBILE Kconfig symbol
Message-ID: <20180828151011.14065-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS") started
the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas ARM SoCs.
Now all dependencies have been merged, this patch series completes the
conversion by removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.

Changes compared to v1:
  - Drop updates of dependencies for drivers, all merged.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
  arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

 arch/arm/mach-shmobile/Kconfig |  4 ----
 arch/arm64/Kconfig.platforms   | 44 ++++++++++++++++------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
