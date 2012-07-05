From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 08:51:45 +0800
Subject: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
In-Reply-To: <1340958180-2291-6-git-send-email-marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-6-git-send-email-marex@denx.de>
Message-ID: <20120705005143.GF2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 10:22:58AM +0200, Marek Vasut wrote:
> +config SPI_MXS
> +	tristate "Freescale MXS SPI controller"
> +	depends on ARCH_MXS
> +	help
> +	  SPI driver for Freescale MXS devices.
> +

...

> +	stmp_reset_block(ssp->base);
> +
So SPI_MXS may need to select STMP_DEVICE.

-- 
Regards,
Shawn
