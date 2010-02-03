From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 17:46:31 +0100
Subject: [PATCH 10/13] ARM: LPC32XX: Phytec PHY3250 platform support file
In-Reply-To: <1264643011-17390-11-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-11-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203164631.GL11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
> +	/* Maintainer: Kevin Wells, NXP Semiconductors */
> +	.phys_io	= UART5_BASE,
> +	.io_pg_offst	= ((io_p2v(UART5_BASE))>>18) & 0xfffc,
> +	.boot_params	= 0x80000100,
Assuming a recent boot loader you don't need boot_params.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
