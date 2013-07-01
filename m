From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 2 Jul 2013 00:55:03 +0200
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
 <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
Message-ID: <20130701225503.GU4634@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 02:56:36PM +0200, Philipp Zabel wrote:
> /*
>  * The CODA driver needs the raw firmware without header in memory order.
>  * This is how I converted vpu_fw_imx53.bin from the Freescale BSP into
>  * v4l2-coda7541-imx53.bin:
>  */

That code sniplet should get a GPL license header.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
