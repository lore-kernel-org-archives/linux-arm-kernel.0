From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 5 Oct 2018 09:43:01 +0200
Subject: [PATCH 0/2] spi: spi-mem: add stm32 qspi controller
Message-ID: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

The goal of this serie is to add support of qspi controller for stm32.
It is a specialized communication interface targeting single,
dual or quad SPI Flash memories (NOR/NAND).

Ludovic Barre (2):
  dt-bindings: spi: add stm32 qspi controller
  spi: spi-mem: add stm32 qspi controller

 .../devicetree/bindings/spi/spi-stm32-qspi.txt     |  44 ++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-stm32-qspi.c                       | 512 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
 create mode 100644 drivers/spi/spi-stm32-qspi.c

-- 
2.7.4
