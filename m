From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri,  6 Jul 2018 14:16:26 -0700
Subject: No subject
Message-ID: <1530911788-7033-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: [GIT PULL 1/3] ARM: Keystone DTS update for v4.19

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.19

for you to fetch changes up to f7e8a182a41e791cca3d7a9e25adddf2908bddde:

  ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model (2018-06-29 15:57:27 -0700)

----------------------------------------------------------------
ARM: Keystone DTS updates for 4.19

 - K2G NIC drriver support
 - Enbale network support for K2G ICE and EVM boards
 - Hardware Ring driver support for k2hk, k2l and k2e socs
 - Add MMC supply for k2g EVM

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
      ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model

Murali Karicheri (3):
      ARM: dts: k2g: add dt bindings to support network driver
      ARM: dts: keystone-k2g-evm: Enable netcp network driver
      ARM: dts: keystone-k2g-ice: Enable netcp network driver

Vitaly Andrianov (3):
      ARM: dts: k2hk: add dts node for k2hk hw_rng driver
      ARM: dts: k2l: add dts node for k2l hw_rng driver
      ARM: dts: k2e: add dts node for k2e hw_rng driver

 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  |  20 ++++
 arch/arm/boot/dts/keystone-k2g-evm.dts     |  63 +++++++++++++
 arch/arm/boot/dts/keystone-k2g-ice.dts     |  59 ++++++++++++
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi  | 147 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi        |  25 +++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi |  20 ++++
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  |  20 ++++
 7 files changed, 346 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
