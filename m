From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 27 Aug 2014 13:51:12 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.17, 2nd take
Message-ID: <20140827055110.GB28777@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3bc4d037c6791c5089a04845995410aac4fdb514:

  ARM: dts: imx6sx: fix the pad setting for uart CTS_B (2014-08-19 20:06:59 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.17-2

for you to fetch changes up to bf8147208eab4a026558dcd686f76410de6c1643:

  ARM: dts: microsom-ar8035: MDIO pad must be set open drain (2014-08-27 13:32:26 +0800)

----------------------------------------------------------------
i.MX fixes for 3.17, 2nd take:
 - Fixes suspend/resume issue on imx53-qsrb due to PMIC IRQ pin
   configuration missing
 - A couple small SolidRun board fixes/correction from Rabeeh
   and Russell

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx53-qsrb: Fix suspend/resume

Rabeeh Khoury (1):
      ARM: dts: microsom-ar8035: MDIO pad must be set open drain

Russell King (2):
      ARM: dts: hummingboard/cubox-i: add USB OC pinctrl configuration
      ARM: dts: hummingboard/cubox-i: change SPDIF output to be more descriptive

 arch/arm/boot/dts/imx53-qsrb.dts               |  8 ++++++++
 arch/arm/boot/dts/imx6dl-hummingboard.dts      |  4 +++-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi         | 19 ++++++++++++++-----
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi |  2 +-
 4 files changed, 26 insertions(+), 7 deletions(-)
