From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 May 2017 11:19:56 +0200
Subject: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
In-Reply-To: <20170521220212.1404-3-wsa@the-dreams.de>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <CGME20170521220747epcas3p3faa8204fb645815ee071f0c803becd8e@epcas3p3.samsung.com>
 <20170521220212.1404-3-wsa@the-dreams.de>
Message-ID: <1676405.bi3L9s8TD3@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 22, 2017 12:02:09 AM Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h2.c          | 2 +-
>  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h3.c          | 2 +-
>  arch/arm/mach-omap1/board-osk.c         | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
>  drivers/mfd/tps65010.c                  | 2 +-
>  drivers/usb/host/ohci-omap.c            | 2 +-
>  drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
>  drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
>  include/linux/{i2c => mfd}/tps65010.h   | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/{i2c => mfd}/tps65010.h (99%)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
