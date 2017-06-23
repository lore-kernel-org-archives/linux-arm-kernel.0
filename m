From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 23 Jun 2017 14:55:42 +0200
Subject: [PATCH 0/8] STM32 SPI various fixes
Message-ID: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset answers to the reviews done after STM32 SPI driver introduction.

Amelie Delaunay (8):
  dt-bindings: spi: stm32: use SoC specific compatible
  spi: stm32: fix compatible to fit with new bindings
  dt-bindings: spi: stm32: fix example with st,spi-midi-ns property
  spi: stm32: replace st,spi-midi with st,spi-midi-ns to fit bindings
  spi: stm32: use normal conditional statements instead of ternary
    operator
  spi: stm32: add runtime PM support
  spi: stm32: enhance DMA error management
  spi: stm32: fix potential dereference null return value

 .../devicetree/bindings/spi/spi-stm32.txt          |   6 +-
 drivers/spi/spi-stm32.c                            | 127 +++++++++++++++------
 2 files changed, 94 insertions(+), 39 deletions(-)

-- 
1.9.1
