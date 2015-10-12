From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Oct 2015 21:45:41 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.3, 2nd round
Message-ID: <20151012134541.GA18611@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0af822110871400908d5b6f83a8908c45f881d8f:

  ARM: dts: fix usb pin control for imx-rex dts (2015-09-24 05:13:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.3-2

for you to fetch changes up to 178b2d09afc05a46f68b190c6594f3a429bc2385:

  ARM: dts: imx7d: Fix UART2 base address (2015-09-30 09:48:21 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.3, 2nd round:

It includes a single fix for i.MX7D, which corrects the base address of
UART2 in device tree.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx7d: Fix UART2 base address

 arch/arm/boot/dts/imx7d.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
