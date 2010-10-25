From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Oct 2010 17:04:54 +0200
Subject: [PATCH 3/4] mx31_3ds: Fix spi registration
In-Reply-To: <AANLkTi=kv7s8StZKEWitrBCdcuKE0qDMBUuAYkTNvAWi@mail.gmail.com>
References: <AANLkTi=kv7s8StZKEWitrBCdcuKE0qDMBUuAYkTNvAWi@mail.gmail.com>
Message-ID: <20101025150454.GK8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rogerio,

On Mon, Oct 25, 2010 at 12:55:14PM -0200, Rogerio Pimentel wrote:
> Commit (06606ff13) "ARM: imx: dynamically register spi_imx devices
> (imx31)" registered the wrong SPI port for mx31_3ds board.
> mx31_3ds uses SPI2 to connect to the MC13783 PMIC.
> 
>  Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>  Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
ups, sorry.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

(BTW, it's at least unusual to indent the Signed-off-by lines)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
