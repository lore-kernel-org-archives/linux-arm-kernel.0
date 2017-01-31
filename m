From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Jan 2017 15:15:10 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#3)
Message-ID: <87vasvz575.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt for mvebu for v4.11.

As for the soc, I hope it is not too late, the support for this new
SoC needed to have several iteration and the last one was mainly
cosmetic. The code was in linux-next since last week by the way. So I
don't expect any regression with it.

Gregory

The following changes since commit a3fe1d5dce142400945ecdc0d2e91b1645b6ebfa:

  ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding (2017-01-19 23:47:11 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.11-3

for you to fetch changes up to 5cb13094484ba89d9a2623ddb72b36ea498e2bff:

  ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards (2017-01-31 14:45:04 +0100)

----------------------------------------------------------------
mvebu dt for 4.11 (part 3)

Add support for Marvell switches with integrated CPUs based on Armada XP

----------------------------------------------------------------
Chris Packham (2):
      ARM: dts: mvebu: Add device tree for 98DX3236 SoCs
      ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards

 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 ++
 .../devicetree/bindings/net/marvell,prestera.txt   |  50 ++++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 254 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  76 ++++++
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  90 ++++++++
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           | 151 ++++++++++++
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      | 142 ++++++++++++
 8 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell,prestera.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
