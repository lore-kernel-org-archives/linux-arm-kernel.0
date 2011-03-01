From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Mar 2011 21:17:03 +0100
Subject: [PATCH 1/5] ARM: mx35_3ds: Add I2C support
In-Reply-To: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110301201703.GX22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 01, 2011 at 04:59:44PM -0300, Fabio Estevam wrote:
> +	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
I'd slightly prefer using 

	imx35_add_imx_i2c(0, ...)

because I intend to remove the imx35_add_imx_i2c0-like macros soon.  But
if nothing else pops up there is no need to respin the series because of
that.

Other than that all 5 patches look good;
	Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
