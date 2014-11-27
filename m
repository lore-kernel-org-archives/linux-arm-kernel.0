From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Nov 2014 11:43:52 +0000
Subject: [PATCH 0/4] spi: st: New driver for ST's SPI Controller
Message-ID: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new driver which controls the SPI component of ST's
Synchronous Serial Controller (SSC).

Lee Jones (4):
  spi: Add new driver for STMicroelectronics' SPI Controller
  spi: st: Provide Device Tree binding documentation
  ARM: sti: Provide DT nodes for SSC[0..4]
  ARM: sti: Provide DT nodes for SBC SSC[0..2]

 Documentation/devicetree/bindings/spi/spi-st.txt |  40 ++
 arch/arm/boot/dts/stih407.dtsi                   |  85 ++++
 drivers/spi/Kconfig                              |   8 +
 drivers/spi/Makefile                             |   1 +
 drivers/spi/spi-st.c                             | 535 +++++++++++++++++++++++
 5 files changed, 669 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-st.txt
 create mode 100644 drivers/spi/spi-st.c

-- 
1.9.1
