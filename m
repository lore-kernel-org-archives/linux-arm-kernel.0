From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 May 2015 15:09:09 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.2
Message-ID: <5555EFF5.1050709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.2

Gregory

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.2

for you to fetch changes up to 973ed08377f6d61dd4e9fd62207737c8ec0d49e9:

  ARM: mvebu: add alias for mdio on Armada 38x (2015-05-11 15:15:26 +0200)

----------------------------------------------------------------
mvebu dt changes for v4.2 (part #1)

- A series adding support for the Compulab CM-A510
- Add alias for mdio on Armada 38x

----------------------------------------------------------------
Imre Kaloz (1):
      ARM: mvebu: add alias for mdio on Armada 38x

Sebastian Hesselbarth (4):
      ARM: dts: dove: Add internal i2c multiplexer node
      ARM: dts: dove: Remove Compulab CM-A510 from Makefile
      ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
      ARM: dts: dove: Add Compulab SBC-A510 to Makefile

 arch/arm/boot/dts/Makefile          |   4 ++--
 arch/arm/boot/dts/armada-38x.dtsi   |   2 +-
 arch/arm/boot/dts/dove-cm-a510.dts  |  38 -----------------------------------
 arch/arm/boot/dts/dove-cm-a510.dtsi | 195
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts | 182
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi         |  40 ++++++++++++++++++++++++++++++++++--
 6 files changed, 418 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
