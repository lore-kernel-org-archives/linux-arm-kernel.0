From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 20 Mar 2017 16:42:31 +0800
Subject: [GIT PULL] i.MX fixes for 4.11
Message-ID: <20170320084229.GH3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.11

for you to fetch changes up to 12aff99723901bcc0e2a6a34343a4f62c371fdd9:

  ARM: dts: imx6sx-udoo-neo: Fix reboot hang (2017-03-08 12:44:46 +0100)

----------------------------------------------------------------
i.MX fixes for 4.11:
 - A fix to reboot hang seen on imx6sx-udoo-neo board, by removing
   arm-supply and soc-supply and using LDO enabled mode.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx6sx-udoo-neo: Fix reboot hang

 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 5 -----
 1 file changed, 5 deletions(-)
