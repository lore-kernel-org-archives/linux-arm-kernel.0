From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Jun 2010 09:19:31 +0200
Subject: [PATCHv4 0/3] Driver for the i.MX2x CMOS Sensor Interface
In-Reply-To: <cover.1277096909.git.baruch@tkos.co.il>
References: <cover.1277096909.git.baruch@tkos.co.il>
Message-ID: <20100621071931.GG12115@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,


> 
> Baruch Siach (3):
>   mx2_camera: Add soc_camera support for i.MX25/i.MX27
>   mx27: add support for the CSI device
>   mx25: add support for the CSI device

applied 2/3 and 3/3 for 2.6.36.

Sascha

> 
>  arch/arm/mach-mx2/clock_imx27.c          |    2 +-
>  arch/arm/mach-mx2/devices.c              |   31 +
>  arch/arm/mach-mx2/devices.h              |    1 +
>  arch/arm/mach-mx25/clock.c               |   14 +-
>  arch/arm/mach-mx25/devices.c             |   22 +
>  arch/arm/mach-mx25/devices.h             |    1 +
>  arch/arm/plat-mxc/include/mach/memory.h  |    4 +-
>  arch/arm/plat-mxc/include/mach/mx25.h    |    2 +
>  arch/arm/plat-mxc/include/mach/mx2_cam.h |   46 +
>  drivers/media/video/Kconfig              |   13 +
>  drivers/media/video/Makefile             |    1 +
>  drivers/media/video/mx2_camera.c         | 1493 ++++++++++++++++++++++++++++++
>  12 files changed, 1625 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/mx2_cam.h
>  create mode 100644 drivers/media/video/mx2_camera.c
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
