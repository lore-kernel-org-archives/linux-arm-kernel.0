From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 23 Nov 2016 13:32:56 +0100
Subject: [git pull] soc_device_match() interface for matching against soc_bus
 attributes
Message-ID: <1479904376-12453-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Olof, Kevin, Arnd,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git tags/soc-device-match-tag1

for you to fetch changes up to da65a1589dacc7ec44ea0557a14d70a39d991f32:

  base: soc: Provide a dummy implementation of soc_device_match() (2016-11-10 10:10:37 +0100)

----------------------------------------------------------------
soc_device_match() interface for matching against soc_bus attributes

This provides core infrastructure as a dependency for several users
(Freescale/NXP, Samsung, Renesas).

Its core parts have been acked by Greg, and the fixes by Arnd and/or
Greg (the last fix only received an informal ack, that's why I hadn't
added the ack).

This has already been pulled by Ulf, and is present in mmc/next, as a
dependency for a Freescale/NXP driver update.

Thanks for pulling!
----------------------------------------------------------------
Arnd Bergmann (1):
      base: soc: Introduce soc_device_match() interface

Geert Uytterhoeven (3):
      base: soc: Early register bus when needed
      base: soc: Check for NULL SoC device attributes
      base: soc: Provide a dummy implementation of soc_device_match()

 drivers/base/Kconfig    |  1 +
 drivers/base/soc.c      | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |  9 ++++++
 3 files changed, 89 insertions(+)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
