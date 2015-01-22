From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Jan 2015 01:42:30 +0100
Subject: [Request pull] mvebu/dt #2
Message-ID: <20150122004230.GC9533@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

There is the second incremental pull request for mvebu/dt.

Thanks
	Andrew

The following changes since commit 928413bd859c0936f03f6a3504c4721e83a3d1d7:

  ARM: mvebu: Add Armada 388 General Purpose Development Board support (2015-01-09 09:20:00 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.20-2

for you to fetch changes up to 6cc082a84e13f3a0078973a08adf22f1404acc3d:

  ARM: mvebu: make DTS comments reflect DEBUG_LL changes (2015-01-21 18:36:14 -0600)

----------------------------------------------------------------
Second set of dt patches for mvebu for v3.20.

ARM: mvebu: make DTS comments reflect DEBUG_LL changes
ARM: mvebu: Armada 385 GP: Add regulators to the SATA port
ARM: Kirkwood: Added support for pogoplug e02 (pink/gray)
ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada 38x
dt: bindings: update mvebu-mbus DT binding with new compatible properties

----------------------------------------------------------------
Christoph Junghans (1):
      ARM: Kirkwood: Added support for pogoplug e02 (pink/gray)

Gregory CLEMENT (1):
      ARM: mvebu: Armada 385 GP: Add regulators to the SATA port

Paul Bolle (1):
      ARM: mvebu: make DTS comments reflect DEBUG_LL changes

Thomas Petazzoni (2):
      dt: bindings: update mvebu-mbus DT binding with new compatible properties
      ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada 38x

 .../devicetree/bindings/bus/mvebu-mbus.txt         |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-375.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-388-gp.dts                | 126 +++++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |   3 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   6 +-
 arch/arm/boot/dts/kirkwood-pogo_e02.dts            | 134 +++++++++++++++++++++
 8 files changed, 270 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-pogo_e02.dts
