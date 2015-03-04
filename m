From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Mar 2015 13:14:19 +0100
Subject: [PATCH 0/2] ARM: shmobile: Enable bockw board in defconfigs
Message-ID: <1425471261-25110-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi,

Now r8a7778 has gained multi-platform support in Simon's branch
r8a7778-ccf-and-multiplatform-for-v4.1, support for r8a7778/bockw can be
enabled in shmobile_defconfig and multi_v7_defconfig.

The options to enable were deduced from r8a7778-bockw.dtb using
https://github.com/geertu/linux-scripts/blob/master/linux-config-from-dt.
This was not tested on bockw due to lack of hardware.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: Enable bockw board in multiplatform defconfig
  ARM: multi_v7_defconfig: Enable shmobile r8a7778/bockw platform

 arch/arm/configs/multi_v7_defconfig | 3 +++
 arch/arm/configs/shmobile_defconfig | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
