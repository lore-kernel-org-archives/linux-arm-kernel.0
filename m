From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Mar 2012 14:30:06 +0100
Subject: [PATCH 1/2] ARM: mx35: 3ds: add mc9s08dz60 gpio definitions
In-Reply-To: <1331528279-2263-1-git-send-email-b39297@freescale.com>
References: <1331528279-2263-1-git-send-email-b39297@freescale.com>
Message-ID: <20120313133006.GF3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 12:57:58PM +0800, Wu Guoxing wrote:
> add a new header file for mx35 3ds board
> add the mc9s08dz60 gpio definitions
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/board_mx35_3ds.h |   26 +++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/board_mx35_3ds.h
> 
> diff --git a/arch/arm/plat-mxc/include/mach/board_mx35_3ds.h b/arch/arm/plat-mxc/include/mach/board_mx35_3ds.h
> new file mode 100644
> index 0000000..df0d5f7
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board_mx35_3ds.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * Author: Wu Guoxing <b39297@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ASM_ARCH_MXC_BOARD_MX35_3DS_H__
> +#define __ASM_ARCH_MXC_BOARD_MX35_3DS_H__
> +
> +#define GPIO_MC9S08DZ60_GPS_ENABLE 0
> +#define GPIO_MC9S08DZ60_HDD_ENABLE 4
> +#define GPIO_MC9S08DZ60_WIFI_ENABLE 5
> +#define GPIO_MC9S08DZ60_LCD_ENABLE 6
> +#define GPIO_MC9S08DZ60_SPEAKER_ENABLE 8

Please add these to the board file instead. They are not useful outside
the board.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
