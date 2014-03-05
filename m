From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 13:03:29 +0800
Subject: [GIT PULL] ARM: i.MX6 device tree changes for 3.15, take 2
Message-ID: <20140305050326.GD8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second batch of i.MX6 device tree changes for 3.15, which is
based on the 'take 1' - tag imx6-dt-3.15.  Please pull, thanks.

Shawn

The following changes since commit 69144bd74456ede4a92a4f6be5782c96dc569737:

  ARM: dts: imx6q: Add support for Zealz GK802 (2014-02-10 16:27:41 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6-dt-3.15-2

for you to fetch changes up to 55b0ef4e1d90b3d05a24f6897da1739ef9b13f75:

  ARM: dts: imx6q-phytec: Added SATA Support (2014-02-21 10:14:02 +0800)

----------------------------------------------------------------
i.MX6 device tree changes for 3.15, take 2:
 - Add USB, GPMI and SATA support for imx6q-phytec board
 - Update imx6sl-evk board support regarding PFUZE100, audio and
   LED etc.
 - Minor updates on a few imx6qdl boards

----------------------------------------------------------------
Anson Huang (2):
      ARM: dts: imx6qdl-sabresd: correct gpio key's active state
      ARM: dts: imx6q: add 852MHz setpoint for CPU freq

Ashutosh singh (4):
      ARM: dts: imx6q-phytec: Added USB_OTG Support
      ARM: dts: imx6q-phytec: Added USB_HOST Support
      ARM: dts: imx6q-phytec: Added GPMI-NAND Support
      ARM: dts: imx6q-phytec: Added SATA Support

Fabio Estevam (5):
      ARM: dts: imx6sl-evk: Add PFUZE100 support
      ARM: dts: imx6sl-evk: Add audio support
      ARM: dts: imx6qdl-sabreauto: Add PFUZE100 support
      ARM: dts: imx6sl-evk: Add debug LED support
      ARM: dts: imx6sl-evk: Keep VGEN1 regulator always enabled

Liu Ying (1):
      ARM: dts: imx6qdl-sabreauto: Support debug LED

Sascha Silbe (1):
      ARM: dts: imx6qdl-wandboard: use GPIO_6 for FEC interrupt

 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |   16 ++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   82 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi               |    2 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   |  132 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |    7 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi   |    3 +
 arch/arm/boot/dts/imx6sl-evk.dts           |  217 ++++++++++++++++++++++++++++
 7 files changed, 456 insertions(+), 3 deletions(-)
