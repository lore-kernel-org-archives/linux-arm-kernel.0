From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 31 Aug 2016 19:05:09 -0400
Subject: [GIT PULL 1/2] ARM: dts: Keystone DTS for 4.9
Message-ID: <1472684710-22905-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.9

for you to fetch changes up to 11b897a2f7c6d6be93f9f6754438f96eed9236df:

  ARM: dts: keystone-k2g: Add Message Manager node (2016-08-31 16:32:16 -0400)

----------------------------------------------------------------
ARM: dts: Keystone DTS for 4.9

Add K2G nodes for GPIO, IRQ and Message Manager

----------------------------------------------------------------
Andrew F. Davis (3):
      ARM: dts: keystone-k2g: Add device state controller node
      ARM: dts: keystone-k2g: Add keystone IRQ controller node
      ARM: dts: keystone-k2g: Add DSP GPIO controller node

Grygorii Strashko (1):
      ARM: dts: keystone: specify usb mode explicitly

Nishanth Menon (1):
      ARM: dts: keystone-k2g: Add Message Manager node

 arch/arm/boot/dts/keystone-k2e-evm.dts  | 12 ++++++++++--
 arch/arm/boot/dts/keystone-k2e.dtsi     |  4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi     | 32 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2hk-evm.dts |  6 +++++-
 arch/arm/boot/dts/keystone-k2l-evm.dts  |  6 +++++-
 arch/arm/boot/dts/keystone.dtsi         |  4 ++--
 6 files changed, 56 insertions(+), 8 deletions(-)
