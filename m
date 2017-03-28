From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 28 Mar 2017 19:07:35 +0300
Subject: [PATCH linux-next v2 0/4] usb: gadget: udc: atmel: Endpoint
 allocation scheme fixes
Message-ID: <cover.1490715349.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch series provides fixes, based on the feedback received on the mailing list, for
the following:
	- fifo table parameters validation against device tree values
	- coding style
	- message display for EP configuration error
	- Kconfig comments for fifo_mode=0

Changes since v1:
	- Removed static for usba_config_fifo_table() function from "Check fifo
	configuration values against device tree" patch

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
