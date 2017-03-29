From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Mar 2017 10:38:36 +0200
Subject: [PATCH linux-next v2 0/4] usb: gadget: udc: atmel: Endpoint
 allocation scheme fixes
In-Reply-To: <cover.1490715349.git.cristian.birsan@microchip.com>
References: <cover.1490715349.git.cristian.birsan@microchip.com>
Message-ID: <fd463735-2c32-c8db-2341-6fc0df6c7044@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2017 ? 18:07, cristian.birsan at microchip.com a ?crit :
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch series provides fixes, based on the feedback received on the mailing list, for
> the following:
> 	- fifo table parameters validation against device tree values
> 	- coding style
> 	- message display for EP configuration error
> 	- Kconfig comments for fifo_mode=0
> 
> Changes since v1:
> 	- Removed static for usba_config_fifo_table() function from "Check fifo
> 	configuration values against device tree" patch

As for previous revision, the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,

> Cristian Birsan (4):
>   usb: gadget: udc: atmel: Check fifo configuration values against
>     device tree
>   usb: gadget: udc: atmel: Minor code cleanup
>   usb: gadget: udc: atmel: Use dev_warn() to display EP configuration
>     error
>   usb: gadget: udc: atmel: Update Kconfig help for fifo_mode = 0
> 
>  drivers/usb/gadget/udc/Kconfig          |  5 ++--
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 47 ++++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 17 deletions(-)
> 


-- 
Nicolas Ferre
