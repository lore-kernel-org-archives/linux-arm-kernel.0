From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 20 Jan 2011 09:20:16 +0100
Subject: [PATCH v2] usb: gadget/fsl_mxc_udc: Detect the CPU type in
	run-time
In-Reply-To: <20110119213250.GF7228@pengutronix.de>
References: <1295468223-11371-1-git-send-email-fabio.estevam@freescale.com>
	<20110119213250.GF7228@pengutronix.de>
Message-ID: <20110120082016.GH7228@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 10:32:51PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Jan 19, 2011 at 06:17:03PM -0200, Fabio Estevam wrote:
> > Make sure we are running on a MX35 processor.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Looks good, Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
looking again s/CONFIG_ARCH_MX35/CONFIG_SOC_IMX35/ would be nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
