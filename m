From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Sep 2012 09:40:25 +0800
Subject: [GIT PULL] imx device tree changes for 3.7 (take 2)
Message-ID: <20120921014022.GK2450@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cb32b4e0fc53ebd45708dd7aa8d7fa224e97308c:

  Merge tag 'imx-clk-dt-lookup' into imx/dt-for-3.7-2 (2012-09-17 15:12:28 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.7-2

for you to fetch changes up to cc7887c3b1a08d3900160d93df4ddda5fa7f725b:

  ARM: imx6q: use pll2_pfd2_396m as the enfc_sel's parent (2012-09-19 13:30:03 +0800)

----------------------------------------------------------------
This is the second round of imx-dt patches for 3.7.  It's based on
and imx-dt-3.7 and imx-clk-dt-lookup which have already been pulled.

----------------------------------------------------------------
Huang Shijie (1):
      ARM: imx6q: use pll2_pfd2_396m as the enfc_sel's parent

Richard Zhao (2):
      ARM: dts: imx6q-sabrelite: add usbmisc device
      ARM: dts: imx6q-sabrelite: add usbotg pinctrl support

 arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
 arch/arm/boot/dts/imx6q.dtsi          |   19 +++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c         |    7 +++++++
 3 files changed, 29 insertions(+)
