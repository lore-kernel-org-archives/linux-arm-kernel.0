From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 11:28:29 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.19 (#1)
Message-ID: <87wotzbi2q.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.19.

Gregory

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.19-1

for you to fetch changes up to 96487173aaf69216fe4d7f8241ef42a539969789:

  ARM: dts: armada388-clearfog: drop future changes disclaimer (2018-06-28 17:04:15 +0200)

----------------------------------------------------------------
mvebu dt for 4.19 (part 1)

 - Add a new Armada 388 based board: helios4
 - Enable SPI flash by default on SolidRun Armada 38x Microsom

----------------------------------------------------------------
Baruch Siach (2):
      ARM: dts: armada388-clearfog: enable spi flash
      ARM: dts: armada388-clearfog: drop future changes disclaimer

Dennis Gilmore (1):
      ARM: dts: armada388-helios4

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-388-clearfog-base.dts     |   5 -
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      |   5 -
 arch/arm/boot/dts/armada-388-clearfog.dts          |   7 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi         |   7 +-
 arch/arm/boot/dts/armada-388-helios4.dts           | 313 +++++++++++++++++++++
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi |   6 -
 7 files changed, 316 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-388-helios4.dts
