From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 May 2015 20:16:49 +0200
Subject: [PATCH 0/5] ARM: shmobile: dts: Replace "nor-jedec" by "jedec,
 spi-nor"
Message-ID: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series replaces the recently introduced "nor-jedec"
compatible value by "jedec,spi-nor" in all shmobile dts files,
cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec,spi-nor"'), which was applied in
v4.1-rc4.

As the "bad" compatible values are already in -next for v4.2, these
updates should be applied and queued for v4.2, too.

Thanks for applying!

Geert Uytterhoeven (5):
  ARM: shmobile: bockw-reference dts: Replace "nor-jedec" by
    "jedec,spi-nor"
  ARM: shmobile: bockw dts: Replace "nor-jedec" by "jedec,spi-nor"
  ARM: shmobile: lager dts: Replace "nor-jedec" by "jedec,spi-nor"
  ARM: shmobile: henninger dts: Replace "nor-jedec" by "jedec,spi-nor"
  ARM: shmobile: koelsch dts: Replace "nor-jedec" by "jedec,spi-nor"

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
