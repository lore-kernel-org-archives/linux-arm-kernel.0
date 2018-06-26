From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 26 Jun 2018 09:50:08 +0200
Subject: [PATCH 0/2] ARM: dts: Correct SCU unit address
Message-ID: <20180626075010.15611-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi All,

This patch series fixes the unit address for the SCU node in the ux500
DT source, which has spread to the UX500 and generic ARM DT bindings.

Thanks!

Geert Uytterhoeven (2):
  ARM: dts: ux500: Correct SCU unit address
  dt-bindings: arm: scu: Correct example SCU unit addresses

 Documentation/devicetree/bindings/arm/scu.txt          | 2 +-
 Documentation/devicetree/bindings/arm/ux500/boards.txt | 2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
