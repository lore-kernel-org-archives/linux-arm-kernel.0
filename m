From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Jul 2014 13:41:37 -0400
Subject: [GIT PULL] Keystone DTS update for 3.17
Message-ID: <1405618897-10350-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone DTS updates for 3.17.

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to 6592f671a4e6ee6308ddd67c2459dd71836770df:

  ARM: dts: keystone-evm: add 1g ethernet phys nodes (2014-07-17 13:29:06 -0400)

----------------------------------------------------------------
Keystone DTS update for 3.17
 - Ethernet clock tree fix.
 - MDIO device tree node. Respective driver update is already queued.
 - Ethernet phy node. Respective driver update is already queued.

----------------------------------------------------------------
Grygorii Strashko (3):
      ARM: dts: keystone: fix netcp's clocks definitions
      ARM: dts: keystone: add mdio devices entries
      ARM: dts: keystone-evm: add 1g ethernet phys nodes

 arch/arm/boot/dts/k2e-clocks.dtsi      |    2 +-
 arch/arm/boot/dts/k2hk-clocks.dtsi     |    2 +-
 arch/arm/boot/dts/k2hk-evm.dts         |   12 ++++++++++++
 arch/arm/boot/dts/k2l-clocks.dtsi      |    2 +-
 arch/arm/boot/dts/keystone-clocks.dtsi |    2 +-
 arch/arm/boot/dts/keystone.dtsi        |   11 +++++++++++
 6 files changed, 27 insertions(+), 4 deletions(-)
