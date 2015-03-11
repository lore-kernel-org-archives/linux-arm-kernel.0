From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Mar 2015 12:55:07 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.0
Message-ID: <20150311045505.GB20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.0

for you to fetch changes up to 2de9dd0391a74e80922c1bc95a78cedf85bcdc9e:

  ARM: imx6sl-evk: set swbst_reg as vbus's parent reg (2015-03-11 09:21:22 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.0:

It includes a couple of i.MX6 dts fixes, which set an input supply to
vbus regulator.  Without the fixes, the voltage of vbus is incorrect
after system boots up.

----------------------------------------------------------------
Peter Chen (2):
      ARM: imx6qdl-sabresd: set swbst_reg as vbus's parent reg
      ARM: imx6sl-evk: set swbst_reg as vbus's parent reg

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 arch/arm/boot/dts/imx6sl-evk.dts       | 2 ++
 2 files changed, 4 insertions(+)
