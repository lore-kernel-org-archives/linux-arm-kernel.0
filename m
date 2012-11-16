From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Nov 2012 16:32:14 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20121116153214.GW10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc.

Sascha

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes-rc

for you to fetch changes up to 3d5e2abe6e265acc5e1fda810301243e9bac92b2:

  ARM: imx: ehci: fix host power mask bit (2012-11-16 15:55:05 +0100)

----------------------------------------------------------------
ARM i.MX fixes for 3.7-rc

----------------------------------------------------------------
Christoph Fritz (1):
      ARM: imx: ehci: fix host power mask bit

Wei Yongjun (1):
      ARM i.MX: fix error-valued pointer dereference in clk_register_gate2()

 arch/arm/mach-imx/clk-gate2.c  |    2 +-
 arch/arm/mach-imx/ehci-imx25.c |    2 +-
 arch/arm/mach-imx/ehci-imx35.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
