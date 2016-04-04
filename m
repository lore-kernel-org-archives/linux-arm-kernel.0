From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Apr 2016 11:09:13 +0200
Subject: [GIT PULL] ARM RealView device tree files
Message-ID: <CACRpkdZ1eEC+iDKdRhgXPGKTuoyNCo-bgk1ii62RoqR03_JUtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a set of ARM RealView device tree files that only use
existing bindings and with all new or controversial stuff stripped
out.

This needs to get into linux-next and get some rotation.

Please pull them to some DTS branch.

Yours,
Linus Walleij

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-dts-1

for you to fetch changes up to dfc8a117388786ab3cfdf0880a09abd05c4e0a4d:

  ARM: dts: realview: DT support for the PBA8 and PBX-A9 (2016-04-04
10:58:05 +0200)

----------------------------------------------------------------
Versatile DTS changes, baseline for the v4.7 series:
- Add CLCD panel nodes to PB1176 and PB11MPCore
- Add a DT binding blurb for the Versatile IB2 syscon
- Add DTS files for the (QEMU supported) RealView EB
  boards in all variants.
- Add DTS files for the (QEMU supported) RealView PBA8
  and PBX-A9 board variants.

----------------------------------------------------------------
Linus Walleij (5):
      Documentation/DT: add blurb for IB2 syscon to Versatile
      ARM: dts: realview: PB11MPCore: define a standard VGA panel
      ARM: dts: realview: PB1176: define a standard VGA panel
      ARM: dts: realview: support all the RealView EB board variants
      ARM: dts: realview: DT support for the PBA8 and PBX-A9

 Documentation/devicetree/bindings/arm/arm-boards |   8 +
 arch/arm/boot/dts/Makefile                       |   8 +-
 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts  |  93 ++++
 arch/arm/boot/dts/arm-realview-eb-11mp.dts       |  74 ++++
 arch/arm/boot/dts/arm-realview-eb-a9mp.dts       |  70 +++
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi        | 225 ++++++++++
 arch/arm/boot/dts/arm-realview-eb.dts            | 166 +++++++
 arch/arm/boot/dts/arm-realview-eb.dtsi           | 453 +++++++++++++++++++
 arch/arm/boot/dts/arm-realview-pb1176.dts        |  40 ++
 arch/arm/boot/dts/arm-realview-pb11mp.dts        |  19 +-
 arch/arm/boot/dts/arm-realview-pba8.dts          | 178 ++++++++
 arch/arm/boot/dts/arm-realview-pbx-a9.dts        | 229 ++++++++++
 arch/arm/boot/dts/arm-realview-pbx.dtsi          | 542 +++++++++++++++++++++++
 13 files changed, 2095 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-mp.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-pba8.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx-a9.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx.dtsi
