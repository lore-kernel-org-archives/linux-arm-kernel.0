From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 16:02:16 +0200
Subject: i.MX51 nand resources
Message-ID: <1281103338-19423-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds the necessary resources for i.MX51
nand.

Sascha

The following changes since commit fc1caf6eafb30ea185720e29f7f5eccca61ecd60:

  Merge branch 'drm-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2010-08-05 16:02:01 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-pu

Sascha Hauer (2):
      ARM i.MX51: Add Nand clock support
      ARM i.MX51: Add Nand device support

 arch/arm/mach-mx5/clock-mx51.c |   98 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices.c    |   25 ++++++++++
 arch/arm/mach-mx5/devices.h    |    1 +
 3 files changed, 124 insertions(+), 0 deletions(-)
