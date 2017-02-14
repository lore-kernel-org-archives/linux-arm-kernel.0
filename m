From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 14 Feb 2017 18:09:02 +0200
Subject: [PATCH 0/4 linux-next] usb: gadget: udc: atmel: Endpoint allocation
 scheme fixes
Message-ID: <cover.1487007870.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch series provides fixes, based on the feedback received on the mailing list, for
the following:
	- fifo table parameters validation against device tree values
	- coding style
	- message display for EP configuration error
	- Kconfig comments for fifo_mode=0

Cristian Birsan (4):
  usb: gadget: udc: atmel: Check fifo configuration values against
    device tree
  usb: gadget: udc: atmel: Minor code cleanup
  usb: gadget: udc: atmel: Use dev_warn() to display EP configuration
    error
  usb: gadget: udc: atmel: Update Kconfig help for fifo_mode = 0

 drivers/usb/gadget/udc/Kconfig          |  5 ++--
 drivers/usb/gadget/udc/atmel_usba_udc.c | 47 ++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.7.4
