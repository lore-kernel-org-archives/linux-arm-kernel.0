From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Apr 2017 12:08:06 +0200
Subject: [PATCH 0/3] arm: dts: renesas: Drop _clk suffix from clock node names
Message-ID: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

The current practice is to not add _clk suffixes to clock node names in
DT, as these names are used as the actual clock names.

This patch removes the remaining offenders in the various Renesas DTSes.

Thanks!

Geert Uytterhoeven (3):
  ARM: dts: r8a7790: Drop _clk suffix from external CAN clock node name
  ARM: dts: r8a7791: Drop _clk suffix from external CAN clock node name
  arm64: dts: r8a7795: salvator-x: Drop _clk suffix from X12 clock node
    name

 arch/arm/boot/dts/r8a7790.dtsi                     | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
