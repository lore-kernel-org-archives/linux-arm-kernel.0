From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 15:46:35 -0500
Subject: [PATCH 0/3] ARM: dts: keystone-k2g-evm: Add SPI nodes and enable SPI1
 on K2G EVM
Message-ID: <20170908204638.13149-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the binding document to indicate the required requirements
for 66AK2G. In addition add the proper SPI nodes for 66AK2G. For K2G
EVM enable SPI1 which is used for the on board SPI NOR.

Franklin S Cooper Jr (1):
  dt-bindings: spi: spi-davinci: Update binding for 66AK2Gx pwr dm
    property

Murali Karicheri (1):
  ARM: dts: keystone-k2g-evm: add bindings for SPI NOR flash

Vitaly Andrianov (1):
  ARM: dts: keystone-k2g: Add SPI nodes

 .../devicetree/bindings/spi/spi-davinci.txt        | 10 +++++
 arch/arm/boot/dts/keystone-k2g-evm.dts             | 37 +++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi                | 48 ++++++++++++++++++++++
 3 files changed, 95 insertions(+)

-- 
2.9.4.dirty
