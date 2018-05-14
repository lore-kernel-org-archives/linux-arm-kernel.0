From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 May 2018 10:33:00 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.17 (#1)
Message-ID: <87zi123adf.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.17.

Gregory

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.17-1

for you to fetch changes up to f43194c1447c9536efb0859c2f3f46f6bf2b9154:

  ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node (2018-04-27 17:47:24 +0200)

----------------------------------------------------------------
mvebu fixes for 4.17 (part 1)

Declare missing clocks needed for network on Armada 8040 base boards
(such as the McBin)

----------------------------------------------------------------
Maxime Chevallier (2):
      ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
      ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node

 Documentation/devicetree/bindings/net/marvell-pp2.txt | 9 +++++----
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi         | 7 +++++--
 2 files changed, 10 insertions(+), 6 deletions(-)
