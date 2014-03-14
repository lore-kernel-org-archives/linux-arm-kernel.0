From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Mar 2014 10:38:31 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.15 (incr. #5)
Message-ID: <20140314143831.GD15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Well, I lied :)  I thought round #4 would be the last one, but we have
one more.  This is a small set of changes, but it adds nand support for
the brand new Armada 38x SoCs.  It'd be really nice to get it in for
v3.15.

As usual, this is an incremental pull request from tags/mvebu-dt-3.15-4
up to tags/mvebu-dt-3.15-5 in the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit df76299fecb3d921e4762ae540e33d8b9b1c3c1e:

  ARM: dove: drop pinctrl PMU reg property (2014-03-06 20:20:33 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.15-5

for you to fetch changes up to 4de29e636946dbc97586de6136a3c496a55fd5e6:

  ARM: mvebu: Enable NAND controller in Armada 385-DB (2014-03-13 23:37:17 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.15 (incremental #5)

 - mvebu

    - 38x
       - add 2GHz fixed clock, core divider clock, and nand controller

    - 385
       - add nand controller and partitions to 385-DB board

----------------------------------------------------------------
Ezequiel Garcia (4):
      ARM: mvebu: Add a 2 GHz fixed-clock on Armada 38x SoCs
      ARM: mvebu: Add the Core Divider clock to Armada 38x SoCs
      ARM: mvebu: Add support for NAND controller in Armada 38x SoC
      ARM: mvebu: Enable NAND controller in Armada 385-DB

 arch/arm/boot/dts/armada-385-db.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi   | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
