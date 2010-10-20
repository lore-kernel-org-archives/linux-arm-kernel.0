From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 20 Oct 2010 16:53:25 +0800
Subject: [PATCH 0/2] babbage: support mmc device
Message-ID: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are to support mmc device on imx51 babbage board,
based on Wolfram Sang's esdhc driver and Eric B?nard's device
registration bits.

The patches were tested on babbage with Sascha's tree

 git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.37

merging mmc-next branch of cjb's tree below.

 git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

Shawn Guo (2):
 [PATCH 1/2] mmc: quirk fix for timeout problem
 [PATCH 2/2] babbage: esdhc device registration

 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c |   19 +++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c     |    3 ++-
 3 files changed, 22 insertions(+), 1 deletions(-)
