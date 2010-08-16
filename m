From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 15:14:29 +0200
Subject: [PATCH 0/4] clock-imx35: fixes
Message-ID: <1281964473-27484-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following clock specific patchseries with fixes for the mx35
are tested and checked againsted the following Datasheet:

"i.MX35 (MCIMX35) Multimedia Applications Processor Reference Manual,
Rev. 2"

Michael Grzeschik (4):
  clock-imx35: use get_3_3_div helper for get_rate_ipg_per
  clock-imx35: fix divider if ahb is source for ipg_per
  clock-imx35: correct arm and ahb clock calculation
  clock-imx35: Calculate the base clock rate for the IPU unit

 arch/arm/mach-mx3/clock-imx35.c |   41 +++++++++++++++++++++++++++++++-------
 1 files changed, 33 insertions(+), 8 deletions(-)

--
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
