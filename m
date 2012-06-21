From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 13:35:56 +0800
Subject: [PATCH 2/5] DRM i.MX: Add parallel display support
In-Reply-To: <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120621053554.GC3971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:43:24PM +0200, Sascha Hauer wrote:
> +static const struct of_device_id imx_pd_dt_ids[] = {
> +	{ .compatible = "fsl,imx-parallel-display", .data = NULL, },

Can we use particular soc name to define the compatible string?  Also,
the .data initialization seems not needed.

> +	{ /* sentinel */ }
> +};

-- 
Regards,
Shawn
