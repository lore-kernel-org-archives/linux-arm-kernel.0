From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 31 Aug 2018 11:16:16 +0200
Subject: [PATCH 0/2] ARM: defconfig: Enable VIDEO_RENESAS_FDP1
Message-ID: <20180831091618.6616-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,


R-Car Gen2 (and RZ/G1) SoCs have a Fine Display Processor.
Hence enable support for it, now commit 231783073ebfc4ac ("media: v4l:
rcar_fdp1: Enable compilation on Gen2 platforms") has landed in v4.19-rc1.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: defconfig: Enable VIDEO_RENESAS_FDP1
  ARM: multi_v7_defconfig: Enable VIDEO_RENESAS_FDP1

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
