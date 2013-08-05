From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Aug 2013 12:32:14 +0200
Subject: [PATCH v2 2/3] ARM: dts: vf610: Add eDMA node
In-Reply-To: <1375682824-11443-1-git-send-email-b35083@freescale.com>
References: <1375682824-11443-1-git-send-email-b35083@freescale.com>
Message-ID: <20130805103214.GA30913@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 02:07:03PM +0800, Jingchang Lu wrote:
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> changes in v2:
>   using generic dma-channels property instead of fsl,dma-channels.
> 
> diff --git a/include/dt-bindings/dma/vf610-edma.h b/include/dt-bindings/dma/vf610-edma.h
> new file mode 100644
> index 0000000..3ae481c
> --- /dev/null
> +++ b/include/dt-bindings/dma/vf610-edma.h
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_DMA_VF610_H__
> +#define __DT_BINDINGS_DMA_VF610_H__
> +
> +/* DMAMUX0,3 reqeust slot number */
> +#define DMA_MUXID0_UART0_RX	2

Never add defines without a proper namespace. I suggest VF610_ here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
