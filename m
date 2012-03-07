From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Mar 2012 21:54:29 +0100
Subject: [GIT PULL] i.MX 35/5 AIPS Setup
Message-ID: <20120307205429.GO3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd,

Please pull the following for -next. It contains Fabios Aips setup
patches. They depend on your imx/soc branch.

Sascha

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx35-imx5-aips-setup

for you to fetch changes up to 38bb3630bcba25f16106166a4aaf211c1d195863:

  ARM: mx35: Setup the AIPS registers (2012-03-07 21:29:57 +0100)

----------------------------------------------------------------
i.MX35/5 AIPS setup

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: mx5: Use common function for configuring AIPS
      ARM: mx35: Setup the AIPS registers

 arch/arm/mach-imx/cpu-imx5.c |   36 ------------------------------------
 arch/arm/mach-imx/mm-imx3.c  |    4 ++++
 arch/arm/mach-imx/mm-imx5.c  |    8 ++++++++
 3 files changed, 12 insertions(+), 36 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
