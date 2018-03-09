From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 14:17:50 +0800
Subject: [GIT PULL] i.MX fixes for 4.16, round 2
Message-ID: <20180309061749.GK3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c0c6bb2322964bd264b4ddedaa5776f40c709f0c:

  ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6 DualLite/Solo RQS (2018-02-24 16:53:09 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.16-2

for you to fetch changes up to 970656b3246d30955894951ed16bd658e42d8c24:

  ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name (2018-03-08 16:16:07 +0800)

----------------------------------------------------------------
i.MX fixes for 4.16, 2nd round:
 - Fix a copy-paste error in imx7d-sdb device tree, which results in two
   usb-otg regulators are both named "regulator-usb-otg1-vbus" and
   override each other.

----------------------------------------------------------------
Leonard Crestez (1):
      ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name

 arch/arm/boot/dts/imx7d-sdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
