From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 15:39:58 +0800
Subject: [PATCH 01/16] ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
In-Reply-To: <20120614073145.GB2086@shlinux2.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-2-git-send-email-shawn.guo@linaro.org>
 <20120614073145.GB2086@shlinux2.ap.freescale.net>
Message-ID: <20120614073956.GD31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:31:46PM +0800, Dong Aisheng wrote:
> > -		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
> > +		/* irq number is run-time assigned */
> Maybe this line is not need.
> 
Documentation never harms.

Regards,
Shawn
