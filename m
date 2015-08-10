From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Aug 2015 23:35:42 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.2, 3rd round
Message-ID: <20150810153542.GA10035@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e053f96b1a00022b4e2c7ceb7ac0229646626507:

  ARM: dts: i.MX35: Fix can support. (2015-07-25 11:35:08 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.2-3

for you to fetch changes up to 1a9fa190956f45c1e58c4d8bfa5ac051691ea590:

  ARM: imx6: correct i.MX6 PCIe interrupt routing (2015-08-06 16:30:18 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.2, 3rd round:
 - Fix i.MX6 PCIe interrupt routing which gets missed from stacked IRQ
   domain conversion.  The PCIe wakeup support is currently broken
   because of this.

----------------------------------------------------------------
Lucas Stach (1):
      ARM: imx6: correct i.MX6 PCIe interrupt routing

 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
