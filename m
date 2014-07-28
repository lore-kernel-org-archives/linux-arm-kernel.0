From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jul 2014 10:38:11 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17 (round 4)
Message-ID: <20140728143811.GT23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here is hopefully the last round of changes for v3.17.  These came in a
little late, but as they are DT only, I hope they can be merged.

Based on tags/mvebu-dt-3.17-3, please pull.

thx,

Jason.


The following changes since commit 112dc53db1c27594e3b1504189c2004115fb1914:

  ARM: mvebu: Add missing MDIO clock in Armada 375 (2014-07-23 12:04:40 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.17-4

for you to fetch changes up to 40c2da45366171bdc9ad1968489aaae190248383:

  ARM: mvebu: Add dts definition for Lenovo Iomega ix4-300d NAS (2014-07-28 13:59:41 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.17 (round 4)

 - Armada XP
    - New board, Lenovo ix4-300d NAS
    - Add Lenovo to vendor-prefixes

 - Dove
    - Add LCD controllers

----------------------------------------------------------------
Benoit Masson (2):
      of: Add Lenovo Group Ltd. to the vendor-prefixes list.
      ARM: mvebu: Add dts definition for Lenovo Iomega ix4-300d NAS

Russell King (1):
      ARM: dts: dove: add DT LCD controllers

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    | 284 +++++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                        |  14 +
 4 files changed, 301 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
