From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Mar 2012 20:22:49 +0100
Subject: [GIT PULL] i.MX35 3ds updates
Message-ID: <20120314192249.GR3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following board updates for the i.MX35 3ds board.

Sascha

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx35-cam-fb

for you to fetch changes up to 25af2d9f85750bb129eb224b7b3a07d3c93d282d:

  i.MX35-PDK: Add Camera support (2012-03-14 20:16:09 +0100)

----------------------------------------------------------------
ARM i.MX35 3ds: Framebuffer and camera support

----------------------------------------------------------------
Alex Gershgorin (1):
      i.MX35-PDK: Add Camera support

wu guoxing (1):
      ARM : mx35: 3ds-board: add framebuffer device

 arch/arm/mach-imx/mach-mx35_3ds.c |  216 +++++++++++++++++++++++++++++++++++++
 1 files changed, 216 insertions(+), 0 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
