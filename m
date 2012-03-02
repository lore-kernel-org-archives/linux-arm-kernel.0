From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Mar 2012 08:30:20 +0100
Subject: [GIT PULL] i.MX visstrim patches
Message-ID: <20120302073020.GH26642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following i.MX27 visstrim driver updates for
-next.

Sascha


The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git features/imx27-visstrim

for you to fetch changes up to acb6464c7bcbfe23a9979f1eeed5acd9aff49774:

  i.MX27: visstrim_m10: Add led support. (2012-03-02 08:25:54 +0100)

----------------------------------------------------------------
Javier Martin (5):
      i.MX27: visstrim_m10: Add m41t00 RTC support.
      i.MX27: visstrim_m10: Sort IMX_HAVE_PLATFORM_MXC_MMC properly.
      i.MX27: visstrim_m10: Register I2C devices after I2C busses have been added.
      i.MX27: visstrim_m10: Add video support.
      i.MX27: visstrim_m10: Add led support.

 arch/arm/mach-imx/Kconfig                   |    4 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |  139 ++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 3 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
