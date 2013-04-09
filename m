From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 20:55:06 +0800
Subject: [PATCH 7/7] staging: drm/imx: Add support for Television Encoder
 (TVEv2)
In-Reply-To: <1365437078-22579-8-git-send-email-p.zabel@pengutronix.de>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
 <1365437078-22579-8-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130409125505.GI5044@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 06:04:38PM +0200, Philipp Zabel wrote:
> This driver adds support for the Television Encoder integrated
> on i.MX53 SoCs (TVEv2).
> 
> Currently only the VGA output mode is supported, which only uses
> the TVDAC to generate RGB levels. HSYNC and VSYNC signals are
> routed directly from the IPU signal generator pins through IOMUXC.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/staging/imx-drm/Kconfig   |   7 +
>  drivers/staging/imx-drm/Makefile  |   1 +
>  drivers/staging/imx-drm/imx-tve.c | 755 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 763 insertions(+)
>  create mode 100644 drivers/staging/imx-drm/imx-tve.c

Bindings doc is missing.

Shawn
