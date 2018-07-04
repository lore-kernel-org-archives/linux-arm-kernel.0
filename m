From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Jul 2018 13:43:28 +0200
Subject: [PATCH 0/5] ARM: shmobile: defconfig: Miscellaneous updates
Message-ID: <20180704114333.27584-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

Here are a few updates for shmobile_defconfig, all fairly independant.

If accepted, I'll submit the corresponding changes for
multi_v7_defconfig.

Thanks!

Geert Uytterhoeven (5):
  ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
  ARM: shmobile: defconfig: Enable reset controller support
  ARM: shmobile: defconfig: Enable support for RZN1D-DB
  ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
  ARM: shmobile: defconfig: Set CONFIG_LOCALVERSION

 arch/arm/configs/shmobile_defconfig | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
