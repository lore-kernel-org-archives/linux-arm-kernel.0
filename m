From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 15:43:11 +0100
Subject: [GIT PULL] i.MX Board update
Message-ID: <20121122144311.GG10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following board update for i.MX.

Sascha

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-board

for you to fetch changes up to 038bdf63a72ac02a987981cf987622fd2de63f51:

  Visstrim SM10: Use mo_version to decide board video mode. (2012-11-02 09:23:30 +0100)

----------------------------------------------------------------
ARM i.MX specific board updates for v3.8

----------------------------------------------------------------
Javier Martin (1):
      Visstrim SM10: Use mo_version to decide board video mode.

 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   52 ++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 5 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
