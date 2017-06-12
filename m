From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Sun, 11 Jun 2017 20:42:13 -0700
Subject: [GIT PULL] ARM: Keystone DTS for v4.13
Message-ID: <1497238933-5379-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.13

for you to fetch changes up to 84e00e244176baec37c66b1cbee6b8a2f7dbd76f:

  ARM: dts: keystone: Add minimum support for K2G ICE evm (2017-05-21 22:47:49 -0700)

----------------------------------------------------------------
ARM: dts: Keystone K2G ICE EVM support for v4.13

----------------------------------------------------------------
Franklin S Cooper Jr (4):
      ARM: dts: keystone-k2g: Remove skeleton.dtsi
      ARM: dts: k2g-evm: Add unit address to memory node
      ARM: keystone: Create new binding for K2G ICE evm
      ARM: dts: keystone: Add minimum support for K2G ICE evm

 .../devicetree/bindings/arm/keystone/keystone.txt  |  3 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |  2 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts             | 35 ++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi                |  3 +-
 5 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-ice.dts
