From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Feb 2018 19:16:45 +0000
Subject: [PATCH v2 0/2]add support for Socionext SynQuacer I2C controller
Message-ID: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.

v2:
- incorporate Andy's review comments (#2)
- patch #1 unchanged.

Ard Biesheuvel (2):
  dt-bindings: i2c: add binding for Socionext SynQuacer I2C
  i2c: add support for Socionext SynQuacer I2C controller

 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
 drivers/i2c/busses/Kconfig                              |  11 +
 drivers/i2c/busses/Makefile                             |   1 +
 drivers/i2c/busses/i2c-synquacer.c                      | 796 ++++++++++++++++++++
 4 files changed, 837 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 drivers/i2c/busses/i2c-synquacer.c

-- 
2.11.0
