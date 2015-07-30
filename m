From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Thu, 30 Jul 2015 18:25:06 +0200
Subject: [PATCH v3 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
In-Reply-To: <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
Message-ID: <1438273506.26075.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2015-07-29 at 17:03 +0800, Haibo Chen wrote:
> tuning-step is the delay cell steps in tuning procedure. The default
> value of tuning-step is 1. For imx6 series usdhc, tuning procedure can
> be passed when the tuning-step value is 1. But imx7d usdhc need the
> tuning-step value as 2, otherwise it can't pass the tuning procedure.
> 
> So this patch add the tuning-step setting in driver, so that user can
> set the tuning-step value in dts.

>From your description, the correct tuning-step value only depends on the
SoC. Why not derive it from the compatible string?

Regards,
Jan L?bbe
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
