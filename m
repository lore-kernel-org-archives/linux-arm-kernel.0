From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Aug 2012 20:25:18 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120803122516.GA23791@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 05:39:02PM +0200, Uwe Kleine-K?nig wrote:
> +enum imx35_pads {
> +	/* sed -r -n 's@^#define MX35_PAD_([0-9A-Z_]*)__([0-9A-Z_]*)\s+IOMUX_PAD\(\s*([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9]*),\s*NO_PAD_CTRL\)@\tMX35_PAD_\1, at p' arch/arm/plat-mxc/include/mach/iomux-mx35.h | uniq */

I'm not sure we want to keep a reference to
arch/arm/plat-mxc/include/mach/iomux-mx35.h that is to be removed.

How about moving the comment into commit message?

-- 
Regards,
Shawn
