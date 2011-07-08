From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Jul 2011 08:53:37 +0200
Subject: [PATCH v6 1/4] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <1310102885-4102-2-git-send-email-b32955@freescale.com>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
	<1310102885-4102-2-git-send-email-b32955@freescale.com>
Message-ID: <20110708065337.GN29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang,

On Fri, Jul 08, 2011 at 01:28:02PM +0800, Huang Shijie wrote:
> +/* The size of the resource is fixed. */
> +#define RES_SIZE	6
This name is too generic. Maybe GPMI_NAND_RES_SIZE?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
