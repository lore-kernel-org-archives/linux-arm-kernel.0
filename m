From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:12:53 +0200
Subject: [PATCH 0/5] ARM: shmobile: dts: Add "nor-jedec" compatible value
Message-ID: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series adds the "nor-jedec" compatible value to all device
nodes for JEDEC-compliant SPI FLASHes on Renesas shmobile boards,
It allows the driver to bind against the generic name, cfr. commit
8ff16cf77ce314c2 ("Documentation: devicetree: m25p80: add "nor-jedec"
binding").
	        
This was tested on r8a7791/koelsch. I verified that it also works with
"nor-jedec" only, without the specific compatible value.

Thanks for applying!

Geert Uytterhoeven (5):
  ARM: shmobile: koelsch dts: Add "nor-jedec" compatible value
  ARM: shmobile: lager dts: Add "nor-jedec" compatible value
  ARM: shmobile: henninger dts: Add "nor-jedec" compatible value
  ARM: shmobile: bockw-reference dts: Add "nor-jedec" compatible value
  ARM: shmobile: bockw dts: Add "nor-jedec" compatible value

 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts           | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           | 2 +-
 arch/arm/boot/dts/r8a7791-henninger.dts       | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
