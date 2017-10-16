From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Oct 2017 15:38:52 +0800
Subject: [GIT PULL] i.MX fixes for 4.14
Message-ID: <20171016073851.GA8320@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.14

for you to fetch changes up to 1c86c9dd82f859b474474a7fee0d5195da2c9c1d:

  ARM: dts: imx7d: Invert legacy PCI irq mapping (2017-10-14 23:32:51 +0800)

----------------------------------------------------------------
i.MX fixes for 4.14:
 - Fix the legacy PCI interrupt numbers for i.MX7.  The numbers were
   wrongly coded in an inverted order than what Reference Manual tells.
   It causes problem for PCI devices using legacy interrupt.

----------------------------------------------------------------
Andrey Smirnov (1):
      ARM: dts: imx7d: Invert legacy PCI irq mapping

 arch/arm/boot/dts/imx7d.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
