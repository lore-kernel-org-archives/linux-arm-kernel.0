From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Mar 2012 14:36:10 +0100
Subject: [GIT PULL] i.MX25 iomux fix
Message-ID: <20120313133610.GH3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following (non urgent, for next) fix for the i.MX25
iomux.

Sascha

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx25-iomux-ds

for you to fetch changes up to 1dde9f75b658edcd4fb7e00259206d727702ce61:

  iomux-mx25.h slew rate adjusted for LCD __LD pins (2012-03-13 13:57:07 +0100)

----------------------------------------------------------------
ARM i.MX25: iomux lcd drivestrength fixes

----------------------------------------------------------------
Mehnert (1):
      iomux-mx25.h slew rate adjusted for LCD __LD pins

 arch/arm/plat-mxc/include/mach/iomux-mx25.h |   42 +++++++++++++-------------
 1 files changed, 21 insertions(+), 21 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
