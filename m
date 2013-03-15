From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Mar 2013 14:57:45 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20130315135745.GF1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc.

Thanks
 Sascha

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/arm-imx-fixes-for-3.9-rc

for you to fetch changes up to 5dc2eb7da1e387e31ce54f54af580c6a6f512ca6:

  ARM: i.MX35: enable MAX clock (2013-03-15 14:52:54 +0100)

----------------------------------------------------------------
Two small ARM i.MX fixes for v3.9-rc

- Fix i.MX25 DT compilation
- Enable MAX clk on i.MX35

----------------------------------------------------------------
Sascha Hauer (2):
      ARM: i.MX25: Fix DT compilation
      ARM: i.MX35: enable MAX clock

 arch/arm/mach-imx/clk-imx35.c | 1 +
 arch/arm/mach-imx/imx25-dt.c  | 5 +++++
 2 files changed, 6 insertions(+)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
