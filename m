From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Feb 2012 08:47:01 +0100
Subject: [PATCH v2 0/7] irq_domain for imx tzic and gpio
In-Reply-To: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120216074701.GI3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:47:41AM -0800, Shawn Guo wrote:
> Changes since v1:
>  * Drop the change on generic-irq, which was naked by Rob
>  * Separate DT initializtion flow from non-DT for tzic
>  * Use legacy domain for non-DT and linear for DT
> 
> Shawn Guo (7):
>       dt: add empty of_find_compatible_node function
>       ARM: imx5: adopt generic_chip irq_domain support for tzic
>       ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
>       ARM: imx: eliminate macro IOMUX_TO_IRQ()
>       ARM: imx: eliminate macro IRQ_GPIOx()
>       gpio/mxc: adopt irq_domain for gpio interrupt support
>       ARM: imx: remove macro MXC_GPIO_IRQ_START

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
