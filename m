From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 Jan 2010 10:45:00 +0100
Subject: [PATCH 0/3] RTC driver for i.MX25
In-Reply-To: <cover.1264596212.git.baruch@tkos.co.il>
References: <cover.1264596212.git.baruch@tkos.co.il>
Message-ID: <20100129094500.GN19551@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 03:00:46PM +0200, Baruch Siach wrote:
> These patches add support for the RTC of the i.MX25 chip, which is based on the 
> DryIce block. The driver is based on code from the Freescale i.MX BSP.
> 
> Also included platform code for i.MX25 chip, and the i.MX25 PDK board.
> 
> These patches have been tested on the i.MX25 PDK board.

I added 2/3 and 3/3 to mxc-master. The rtc guys should take care of the
rest.

Sascha


> 
> Baruch Siach (3):
>   rtc: driver for the DryIce block found in i.MX25 chips
>   mx25: add support for the DryIce rtc
>   mx25pdk: platform code for the DryIce RTC module
> 
>  arch/arm/mach-mx25/clock.c            |    2 +
>  arch/arm/mach-mx25/devices.c          |   19 ++
>  arch/arm/mach-mx25/devices.h          |    1 +
>  arch/arm/mach-mx25/mx25pdk.c          |    1 +
>  arch/arm/plat-mxc/include/mach/mx25.h |    2 +
>  drivers/rtc/Kconfig                   |   10 +
>  drivers/rtc/Makefile                  |    1 +
>  drivers/rtc/rtc-imxdi.c               |  559 +++++++++++++++++++++++++++++++++
>  8 files changed, 595 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-imxdi.c
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
