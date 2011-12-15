From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 14:06:43 +0800
Subject: [GIT PULL] imx6/boards for v3.3
Message-ID: <20111215060642.GD21815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following board changes for v3.3.

Regards,
Shawn

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx6/boards

Dirk Behme (1):
      arm/imx6q: Rename Sabreauto to Armadillo2

Eric Miao (1):
      ARM: imx6q: generate imx6q dtb files

Richard Zhao (4):
      dts/imx: rename gpio labels to consistent with hw spec
      dts/imx: rename uart labels to consistent with hw spec
      arm/imx6: add imx6q sabrelite board support
      arm/imx6q-sabrelite: add enet phy ksz9021rn fixup

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +++-
 arch/arm/boot/dts/imx51-babbage.dts                |   17 +++++-----
 arch/arm/boot/dts/imx51.dtsi                       |   20 ++++++------
 arch/arm/boot/dts/imx53-ard.dts                    |   18 +++++-----
 arch/arm/boot/dts/imx53-evk.dts                    |   17 +++++-----
 arch/arm/boot/dts/imx53-qsb.dts                    |   18 +++++-----
 arch/arm/boot/dts/imx53-smd.dts                    |   19 +++++------
 arch/arm/boot/dts/imx53.dtsi                       |   34 ++++++++++----------
 .../dts/{imx6q-sabreauto.dts => imx6q-arm2.dts}    |   12 +++---
 .../{imx6q-sabreauto.dts => imx6q-sabrelite.dts}   |   31 +++++-------------
 arch/arm/boot/dts/imx6q.dtsi                       |   34 ++++++++++----------
 arch/arm/mach-imx/Makefile.boot                    |    3 ++
 arch/arm/mach-imx/mach-imx6q.c                     |   24 +++++++++++++-
 13 files changed, 134 insertions(+), 121 deletions(-)
 copy arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-arm2.dts} (78%)
 rename arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-sabrelite.dts} (54%)
