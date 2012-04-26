From: b32955@freescale.com (Huang Shijie)
Date: Thu, 26 Apr 2012 18:37:10 +0800
Subject: [PATCH 0/2] add DMA support to uart
Message-ID: <1335436632-29499-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA support to UART driver.

Tested this patch on imx6q(arm2) board with a new SDMA firmware.


Huang Shijie (2):
  serial/imx: add DMA support
  ARM: MX6q: enable DMA support for UART2

 .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
 arch/arm/boot/dts/imx6q-arm2.dts                   |    8 +
 drivers/tty/serial/imx.c                           |  386 +++++++++++++++++++-
 3 files changed, 397 insertions(+), 4 deletions(-)
