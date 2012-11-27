From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Nov 2012 15:56:01 +0000
Subject: [GIT PULL] ARM: mvebu: cache-l2x0 for v3.8
Message-ID: <mailman.14.1354031767.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 56580bb422e5f542da19c057f348dd39634138e7:

  Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything (2012-11-24 04:08:49 +0000)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_cache_l2x0_for_3.8

for you to fetch changes up to 3ee11aef75db51c69cb8cb91dd01afb28036f1b5:

  arm: l2x0: add aurora related properties to OF binding (2012-11-27 15:35:43 +0000)

----------------------------------------------------------------
mvebu cache-l2x0 for v3.8

 - Add support for l2x0 cache on mvebu boards

 - Depends on mvebu/everything

----------------------------------------------------------------
Gregory CLEMENT (3):
      arm: mvebu: add L2 cache support
      arm: mvebu: add Aurora L2 Cache Controller to the DT
      arm: l2x0: add aurora related properties to OF binding

 Documentation/devicetree/bindings/arm/l2cc.txt | 9 +++++++++
 arch/arm/boot/dts/armada-370.dtsi              | 6 ++++++
 arch/arm/boot/dts/armada-xp.dtsi               | 7 +++++++
 arch/arm/mach-mvebu/Kconfig                    | 1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c        | 4 ++++
 5 files changed, 27 insertions(+)
