From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Aug 2017 12:24:03 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.14 (#1)
Message-ID: <874lteierg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.14.

Gregory

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.14-1

for you to fetch changes up to 0f015017a95c279a050ed953284451d2a0d29fb2:

  ARM: dts: armada-38x: Add arm_global_timer node (2017-08-03 14:33:24 +0200)

----------------------------------------------------------------
mvebu dt for 4.14 (part 1)

Add arm_global_timer node on Armada 38x

Fix PCI bus dtc warnings on mvebu 32 bits device tree files

----------------------------------------------------------------
Marcin Wojtas (1):
      ARM: dts: armada-38x: Add arm_global_timer node

Rob Herring (1):
      ARM: dts: marvell: fix PCI bus dtc warnings

 Documentation/devicetree/bindings/pci/mvebu-pci.txt |  2 +-
 arch/arm/boot/dts/armada-370.dtsi                   |  4 +++-
 arch/arm/boot/dts/armada-375.dtsi                   |  4 +++-
 arch/arm/boot/dts/armada-380.dtsi                   |  5 ++++-
 arch/arm/boot/dts/armada-385-db-ap.dts              |  2 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts       |  2 +-
 arch/arm/boot/dts/armada-385.dtsi                   |  6 +++++-
 arch/arm/boot/dts/armada-388-clearfog.dts           |  2 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi          |  2 +-
 arch/arm/boot/dts/armada-388-db.dts                 |  2 +-
 arch/arm/boot/dts/armada-388-gp.dts                 |  2 +-
 arch/arm/boot/dts/armada-388-rd.dts                 |  2 +-
 arch/arm/boot/dts/armada-38x.dtsi                   |  7 +++++++
 arch/arm/boot/dts/armada-390-db.dts                 |  2 +-
 arch/arm/boot/dts/armada-395-gp.dts                 |  2 +-
 arch/arm/boot/dts/armada-398-db.dts                 |  2 +-
 arch/arm/boot/dts/armada-39x.dtsi                   |  6 +++++-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi           |  3 ++-
 arch/arm/boot/dts/armada-xp-db.dts                  |  2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                  |  2 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi            |  7 ++++++-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi            | 11 ++++++++++-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi            | 14 ++++++++++++--
 arch/arm/boot/dts/dove-d3plug.dts                   |  4 ++--
 arch/arm/boot/dts/dove.dtsi                         |  8 +++++---
 arch/arm/boot/dts/kirkwood-6192.dtsi                |  3 ++-
 arch/arm/boot/dts/kirkwood-6281.dtsi                |  3 ++-
 arch/arm/boot/dts/kirkwood-6282.dtsi                |  4 +++-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi            |  3 ++-
 29 files changed, 86 insertions(+), 32 deletions(-)
