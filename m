From: b32955@freescale.com (Huang Shijie)
Date: Tue, 9 Jul 2013 15:46:34 +0800
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <20130709070541.GQ516@pengutronix.de>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de>
Message-ID: <51DBBFDA.70302@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?09? 15:05, Sascha Hauer ??:
> Why don't you set the matching order in the driver the way you want it
> to be, i.e.:
>
> 	{ .compatible = "fsl,imx6q-uart", ... },
> 	{ .compatible = "fsl,imx21-uart", ... },
> 	{ .compatible = "fsl,imx1-uart", ... },
>
yes. i can set it like this.

but this method looks like a ugly workaround.

thanks
Huang Shijie
