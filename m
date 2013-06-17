From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 22:03:16 +0800
Subject: [PATCH v2] staging: imx_drm: imx_ldb: fix 18 bit format
In-Reply-To: <1371459772-16443-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1371459772-16443-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130617140314.GJ31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 11:02:52AM +0200, Steffen Trumtrar wrote:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> Since 18 bit is supported as datawidth in device tree it should be
> supported in driver. Beside the LDB channel the IPU channel has also
> to be configured to use BGR666.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> This is based on the series: "staging: drm/imx: Add LDB support" by Philipp.

Greg,

Can you queued this patch and "staging: drm/imx: Add LDB support" from
Philipp Zabel for 3.11 please?  With these two patches, I can boot my
imx6q board into LUbuntu 13.04 with LVDS panel.  So for both patches,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Shawn
