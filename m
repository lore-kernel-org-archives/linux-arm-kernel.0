From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Sep 2010 11:23:06 +0200
Subject: [PATCH] AT91: at91sam9261ek board: remove warnings related to
	use of SPI or SD/MMC
In-Reply-To: <1284113629-13768-2-git-send-email-nicolas.ferre@atmel.com>
References: <1284113629-13768-1-git-send-email-nicolas.ferre@atmel.com>
	<1284113629-13768-2-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20100910092306.GM9112@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/*
> + * MCI (SD/MMC)
> + * spi0 and mmc/sd share the same PIO pins: cannot be used at the same time
> + */
> +static struct at91_mmc_data __initdata ek_mmc_data = {
> +	.wire4		= 1,
> +//	.det_pin	= ... not connected
> +//	.wp_pin		= ... not connected
> +//	.vcc_pin	= ... not connected
can we remove this 3 comments

Best Regards,
J.
