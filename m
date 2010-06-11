From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 11 Jun 2010 09:23:12 +0200
Subject: [PATCH] MAINTAINERS: some Atmel drivers change maintainer
In-Reply-To: <1275054888-13828-1-git-send-email-nicolas.ferre@atmel.com>
References: <20100528114245.3d030692@hskinnemoen-d830>
	<1275054888-13828-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4C11E460.4010101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/05/2010 15:54, Nicolas Ferre :
> I take over the maintenance of SPI, USART, Ethernet and USB gadget drivers.
> Those drivers are found in Atmel microcontrollers, both AT32/AVR32 and
> AT91/ARM.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Ping,

With added acked-by:
Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

> ---
> Haavard,
> I finally change the MAINTAINERS entries for all drivers that you were
> taking care of. I must admit that I was a bit frighten at the first place but
> anyway, since one year, I am getting used to it ;-)
> 
> 
>  MAINTAINERS |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33047a6..d9ce9c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1148,7 +1148,7 @@ F:	drivers/mmc/host/atmel-mci.c
>  F:	drivers/mmc/host/atmel-mci-regs.h
>  
>  ATMEL AT91 / AT32 SERIAL DRIVER
> -M:	Haavard Skinnemoen <hskinnemoen@atmel.com>
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  S:	Supported
>  F:	drivers/serial/atmel_serial.c
>  
> @@ -1160,18 +1160,18 @@ F:	drivers/video/atmel_lcdfb.c
>  F:	include/video/atmel_lcdc.h
>  
>  ATMEL MACB ETHERNET DRIVER
> -M:	Haavard Skinnemoen <hskinnemoen@atmel.com>
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  S:	Supported
>  F:	drivers/net/macb.*
>  
>  ATMEL SPI DRIVER
> -M:	Haavard Skinnemoen <hskinnemoen@atmel.com>
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  S:	Supported
>  F:	drivers/spi/atmel_spi.*
>  
>  ATMEL USBA UDC DRIVER
> -M:	Haavard Skinnemoen <hskinnemoen@atmel.com>
> -L:	kernel at avr32linux.org
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://avr32linux.org/twiki/bin/view/Main/AtmelUsbDeviceDriver
>  S:	Supported
>  F:	drivers/usb/gadget/atmel_usba_udc.*


-- 
Nicolas Ferre
