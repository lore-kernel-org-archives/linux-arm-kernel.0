From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 1 Jun 2015 10:51:04 +0530
Subject: [PATCH V2 0/3] Add RS-485 support and fix RTS/CTS implementation
Message-ID: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V1:
Use common get/set mctrl control methods for both lpuart, lpuart32
and fix indention.

Bhuvanchandra DV (3):
  ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A RTS/CTS pins
  tty: serial: fsl_lpuart: remove RTS/CTS control from set/get_mctrl
  tty: serial: fsl_lpuart: Add support for RS-485

 arch/arm/boot/dts/vf-colibri.dtsi |   2 +
 drivers/tty/serial/fsl_lpuart.c   | 103 ++++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 48 deletions(-)

-- 
2.1.0
