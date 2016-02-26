From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Feb 2016 15:30:45 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.6 (#2)
Message-ID: <878u27o86i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.6.

Gregory

The following changes since commit adbc3695d9e487fa07214140a46b68ac3156fb78:

  arm64: dts: add the Marvell Armada 3700 family and a development board (2016-02-17 16:09:55 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.6-2

for you to fetch changes up to b5ebfad8df1c73df6932d11eeada4caea0ec8f30:

  arm64: dts: marvell: re-order Device Tree nodes for Armada AP806 (2016-02-26 15:17:31 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.6 (part 2)

Add support for the Armada 7K and 8K SoCs and the Armada 8040 DB board

----------------------------------------------------------------
Thomas Petazzoni (3):
      arm64: dts: marvell: add Device Tree files for Armada 7K/8K
      arm64: dts: marvell: update Armada AP806 clock description
      arm64: dts: marvell: re-order Device Tree nodes for Armada AP806

 .../bindings/arm/marvell/armada-7k-8k.txt          |  24 +++
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  92 ++++++++
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  71 ++++++
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  84 ++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 237 +++++++++++++++++++++
 10 files changed, 725 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806.dtsi
