From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Mon, 11 Jun 2012 22:00:11 +0800
Subject: [PATCH 0/5] OMAP3530evm misc fixes for linux-omap
In-Reply-To: <zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
Message-ID: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix misc problems when reflash ti-omap3530evm for
master branch on Linux-omap. Currently they have been tested on
3530evm but were not ack'ed.

Most of them are the leftovers from the great original developers
with my the latest updates for adapting to the current kernel, so
I add you directly into SOB(If not proper, please let me know).

The series is based upon the latest linux-omap master branch from
Tony (3.5-rc1).

Zumeng Chen (5):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      MFD: OMAP3EVM: USB: cosmetic fix to failed parent clk set
      Input: ads7846: set proper debounce time in driver level

 arch/arm/mach-omap2/board-omap3evm.c |   75 ++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/ads7846.c  |    2 +
 drivers/mfd/omap-usb-host.c          |    4 +-
 3 files changed, 80 insertions(+), 1 deletions(-)
