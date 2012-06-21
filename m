From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 14:07:32 +0800
Subject: [PATCH 2/5] DRM i.MX: Add parallel display support
In-Reply-To: <20120621053554.GC3971@S2101-09.ap.freescale.net>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
 <20120621053554.GC3971@S2101-09.ap.freescale.net>
Message-ID: <20120621060730.GA23285@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 01:35:56PM +0800, Shawn Guo wrote:
> On Thu, Jun 14, 2012 at 03:43:24PM +0200, Sascha Hauer wrote:
> > +static const struct of_device_id imx_pd_dt_ids[] = {
> > +	{ .compatible = "fsl,imx-parallel-display", .data = NULL, },
> 
> Can we use particular soc name to define the compatible string?

Just realized that it's actually not representing any hardware block.
If that's the case, I feel we should try to get it away from device
tree.

Regards,
Shawn

> Also,
> the .data initialization seems not needed.
> 
> > +	{ /* sentinel */ }
> > +};
