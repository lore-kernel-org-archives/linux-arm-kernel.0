From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 Sep 2013 19:42:32 -0400
Subject: [PATCH 0/4] ARM: keystone: Enable SPI and I2C support
Message-ID: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is small set of patches which enables I2C and SPI bus support
for Keystone SOCs. The relevant driver updates are already merged
in the last merge cycle. Tested on Keystone 2 EVM.

Santosh Shilimkar (4):
  ARM: dts: keystone: Add i2c device nodes
  ARM: dts: keystone: Add the SPI nodes
  spi: davinci: Allow SPI to be build without EDMA support
  ARM: keystone: Enable I2C and SPI bus support

 arch/arm/boot/dts/keystone.dts      |   57 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |    2 ++
 drivers/spi/Kconfig                 |    2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)

-- 
1.7.9.5
