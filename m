From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 12 May 2014 12:41:39 -0400
Subject: [GIT PULL 2/2] ARM: Keystone DTS updates for 3.16
Message-ID: <1399912899-29640-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone DTS updates for 3.16. It merges cleanly with
arm-soc 'next/dts' head.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to 18131ae615cf20b06860a1b668e0625db714af2e:

  ARM: dts: keystone-evm: add spi nor flash support (2014-05-12 11:43:59 -0400)

----------------------------------------------------------------
Keystone DTS updates for 3.16

- Few of address cell warning fixes.
- Add Lamarr and Edision EVM NOR flash and NAND devices.
- Update dts to make use of dma-ranges and dma-coherent properties.

----------------------------------------------------------------
Grygorii Strashko (5):
      ARM: dts: keystone: add cell's information to i2c nodes
      ARM: dts: keystone: move i2c0 device node from SoC to board files
      ARM: dts: keystone: add cell's information to spi nodes
      ARM: dts: keystone: Use dma-ranges property
      ARM: dts: keystone-evm: add spi nor flash support

Ivan Khoronzhuk (2):
      ARM: dts: k2e-evm: add AEMIF/NAND device entry
      ARM: dts: k2l-evm: add AEMIF/NAND device entry

Lucas Stach (1):
      ARM: dts: keystone: drop address and size cells from GIC node

Santosh Shilimkar (1):
      ARM: dts: keystone: Update USB node for dma properties

 arch/arm/boot/dts/k2e-evm.dts   |   81 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts  |   29 ++++++++++++++
 arch/arm/boot/dts/k2l-evm.dts   |   81 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi |   20 ++++++----
 4 files changed, 204 insertions(+), 7 deletions(-)
