From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 28 Sep 2015 13:24:41 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.3
Message-ID: <20150928052440.GA4843@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.3

for you to fetch changes up to 0af822110871400908d5b6f83a8908c45f881d8f:

  ARM: dts: fix usb pin control for imx-rex dts (2015-09-24 05:13:40 -0700)

----------------------------------------------------------------
The i.MX fixes for 4.3:
 - One fix for i.MX6 Rex Pro board to remove a duplicated pinctrl entry
   which causes error for USB pinctrl setup.
 - Fix MC34708 PMIC interrupt level for imx53-qsrb board.

----------------------------------------------------------------
Felipe F. Tonello (1):
      ARM: dts: fix usb pin control for imx-rex dts

Lucas Stach (2):
      ARM: imx53: include IRQ dt-bindings header
      ARM: imx53: qsrb: fix PMIC interrupt level

 arch/arm/boot/dts/imx53-qsrb.dts   | 2 +-
 arch/arm/boot/dts/imx53.dtsi       | 1 +
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)
