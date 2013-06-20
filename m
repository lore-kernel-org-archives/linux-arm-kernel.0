From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Jun 2013 16:15:04 +0800
Subject: [PATCH v2 7/7] drivers: bus: imx-weim: Change compatible string
 for i.MX6Q
In-Reply-To: <20130620080737.GO32299@pengutronix.de>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-7-git-send-email-shc_work@mail.ru>
 <20130620070959.GE19896@S2101-09.ap.freescale.net>
 <20130620080737.GO32299@pengutronix.de>
Message-ID: <20130620081502.GF19896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 10:07:37AM +0200, Sascha Hauer wrote:
> How about:
> 
> +	{ .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
> +	{ .compatible = "fsl,imx50-weim", .data = &imx50_weim_devtype, },
> 
> We could then change the in-kernel devicetrees how we need it without
> breaking existing devicetrees.
> 
Yeah, it works for me.

Shawn
