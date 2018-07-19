From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 19 Jul 2018 15:51:55 +0900
Subject: [PATCH 0/2] add SPI controller driver for UniPhier SoCs
Message-ID: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for SPI controller driver implemented on UniPhier SoCs.

Keiji Hayashibara (1):
  spi: add SPI controller driver for UniPhier SoC

Kunihiko Hayashi (1):
  dt-bindings: spi: add DT bindings for UniPhier SPI controller

 .../devicetree/bindings/spi/spi-uniphier.txt       |  26 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-uniphier.c                         | 532 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c

-- 
2.7.4
