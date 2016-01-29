From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:30 +0100
Subject: [PATCH v4 00/11] ARM: dts: shmobile: Rename the serial port clock to
 fck
Message-ID: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series renames the serial port clock to fck, as accepted in
the DT bindings in v4.5-rc1.

Changes compared to v4:
  - Changed one-line summary prefix to match current arm-soc practices,
  - Split off h8/300 patch,
  - Rebased,

Changes compared to v3:
  - Add Acked-by,
  - Update for "[PATCH 0/2] ARM: shmobile: r8a7793: Increase scif
    support".

Dependencies:
  - This series was created on top of "[PATCH v4 0/7] ARM: dts: R-Car:
    Add SCIF fallback compatibility strings", but I think it applies to
    plain renesas-devel-20160129-v4.5-rc1, too.

Thanks for applying!

Geert Uytterhoeven (1):
  arm64: dts: r8a7795: Rename the serial port clock to fck

Laurent Pinchart (10):
  ARM: dts: sh73a0: Rename the serial port clock to fck
  ARM: dts: r7s72100: Rename the serial port clock to fck
  ARM: dts: r8a73a4: Rename the serial port clock to fck
  ARM: dts: r8a7740: Rename the serial port clock to fck
  ARM: dts: r8a7778: Rename the serial port clock to fck
  ARM: dts: r8a7779: Rename the serial port clock to fck
  ARM: dts: r8a7790: Rename the serial port clock to fck
  ARM: dts: r8a7791: Rename the serial port clock to fck
  ARM: dts: r8a7793: Rename the serial port clock to fck
  ARM: dts: r8a7794: Rename the serial port clock to fck

 arch/arm/boot/dts/r7s72100.dtsi          | 16 +++++++-------
 arch/arm/boot/dts/r8a73a4.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7740.dtsi           | 18 ++++++++--------
 arch/arm/boot/dts/r8a7778.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7779.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7790.dtsi           | 20 +++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/r8a7793.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/r8a7794.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/sh73a0.dtsi            | 18 ++++++++--------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 22 +++++++++----------
 11 files changed, 119 insertions(+), 119 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
