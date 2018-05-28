From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 28 May 2018 17:10:16 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.17 (#2)
Message-ID: <871sdvyfxj.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.17.
Nothing really critical but it needs to be fixed.

Gregory

The following changes since commit f43194c1447c9536efb0859c2f3f46f6bf2b9154:

  ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node (2018-04-27 17:47:24 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.17-2

for you to fetch changes up to ac62cc9d9cd6fa4c79e171c13dc8d58c3862b678:

  arm: dts: armada: Fix "#cooling-cells" property's name (2018-05-28 16:54:44 +0200)

----------------------------------------------------------------
mvebu fixes for 4.17 (part 2)

 - Use correct size for ICU nodes (irq controller) on Armada 7K/8K
 - Fix "#cooling-cells" property's name on Synology DS116 (Armada 385)

----------------------------------------------------------------
Miquel Raynal (1):
      arm64: dts: marvell: fix CP110 ICU node size

Viresh Kumar (1):
      arm: dts: armada: Fix "#cooling-cells" property's name

 arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
