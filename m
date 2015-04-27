From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:24 +0200
Subject: [PATCH 00/10] ARM: shmobile: Use generic names for device nodes
Message-ID: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Magnus, Simon,

This patch series gets rid of the last non-generic device nodes names in
the shmobile DTS files, and replaces them by generic names, cfr. ePAPR.

Thanks for applying!

Geert Uytterhoeven (10):
  ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
  ARM: shmobile: r8a7778 dtsi: Use generic names for device nodes
  ARM: shmobile: r8a7779 dtsi: Use generic names for device nodes
  ARM: shmobile: r8a7790 dtsi: Use generic names for device nodes
  ARM: shmobile: r8a7791 dtsi: Use generic names for device nodes
  ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
  ARM: shmobile: ape6evm dts: Use generic names for device nodes
  ARM: shmobile: armadillo800eva dts: Use generic names for device nodes
  ARM: shmobile: kzm9d dts: Use generic names for device nodes
  ARM: shmobile: marzen dts: Use generic names for device nodes

 arch/arm/boot/dts/emev2-kzm9d.dts             | 4 ++--
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         | 2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi                | 8 ++++----
 arch/arm/boot/dts/r8a7778.dtsi                | 2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts          | 6 +++---
 arch/arm/boot/dts/r8a7779.dtsi                | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi                | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi                | 2 +-
 arch/arm/boot/dts/sh73a0.dtsi                 | 8 ++++----
 10 files changed, 19 insertions(+), 19 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
