From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 21 Jan 2015 16:53:07 +0100
Subject: [PATCH 0/3] xilinx-spi: Support more spi modes and multiple device
 tree
Message-ID: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches add drier support for hardware implemented modes:
spi_lsb_fist and spi_loop

Also fix an issue when multiple spi devices are defined on a device tree.

Ricardo Ribalda Delgado (3):
  spi/xilinx: Use automatic bus number on device tree
  spi/xilinx: Support for spi mode LSB_FIRST
  spi/xilinx: Support for spi mode LOOP

 drivers/spi/spi-xilinx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.1.4
