From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 11:55:09 +0200
Subject: [GIT PULL] i.MX Fixes
Message-ID: <20120911095509.GT18243@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc

Thanks
 Sascha


The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes

for you to fetch changes up to 48540058612786d365602f3324ed97f9071092de:

  ARM: clk-imx35: Fix SSI clock registration (2012-09-11 11:52:28 +0200)

----------------------------------------------------------------
ARM: i.MX: Fix SSI clock associations for i.MX25/i.MX35

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: clk-imx25: Fix SSI clock registration
      ARM: clk-imx35: Fix SSI clock registration

 arch/arm/mach-imx/clk-imx25.c |    6 ++----
 arch/arm/mach-imx/clk-imx35.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
