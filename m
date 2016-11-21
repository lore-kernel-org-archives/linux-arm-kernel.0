From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 21 Nov 2016 14:32:44 +0100
Subject: [PATCH v5 0/3] Add basic support for the I2C units of the Armada 3700
Message-ID: <20161121133247.29889-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add basic support for the I2C bus interface units present
in the Armada 3700 to the pxa-i2c driver. It also add the definitions of
the device nodes to the devicetree at the SoC level and for its official
development board: the Armada 3720 DB.

Romain Perier (3):
  i2c: pxa: Add support for the I2C units found in Armada 3700
  arm64: dts: marvell: Add I2C definitions for the Armada 3700
  dt-bindings: i2c: pxa: Update the documentation for the Armada 3700

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  1 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 18 +++++++++++++++++
 drivers/i2c/busses/Kconfig                        |  2 +-
 drivers/i2c/busses/i2c-pxa.c                      | 24 +++++++++++++++++++++--
 5 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.9.3
