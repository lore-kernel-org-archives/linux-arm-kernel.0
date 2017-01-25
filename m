From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 25 Jan 2017 14:19:29 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Mark EthernetAVB device nodes
 disabled
Message-ID: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series marks the EthernetAVB device nodes in the R-Car H3 and
M3-W DTSes disabled.
Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTSes, and overridden by board-specific DTSes where needed.

Thanks for applying!

Geert Uytterhoeven (2):
  arm64: dts: r8a7795: Mark EthernetAVB device node disabled
  arm64: dts: r8a7796: Mark EthernetAVB device node disabled

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1 +
 2 files changed, 2 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
