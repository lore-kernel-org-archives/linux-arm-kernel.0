From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 Feb 2017 10:08:13 +0100
Subject: [PATCH 0/4 linux-next] usb: gadget: udc: atmel: Endpoint
 allocation scheme fixes
In-Reply-To: <cover.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <38c7331c-0286-9874-c3b5-819c8dba6153@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/02/2017 ? 17:09, cristian.birsan at microchip.com a ?crit :
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch series provides fixes, based on the feedback received on the mailing list, for
> the following:
> 	- fifo table parameters validation against device tree values
> 	- coding style
> 	- message display for EP configuration error
> 	- Kconfig comments for fifo_mode=0
> 
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

I'm okay with the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, regards,
-- 
Nicolas Ferre
