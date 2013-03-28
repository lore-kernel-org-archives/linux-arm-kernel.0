From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 14:08:08 +0800
Subject: [PATCH v2 01/11] staging: drm/imx: Add LDB support
In-Reply-To: <1364405445-5271-2-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130328060806.GI5429@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 06:30:35PM +0100, Philipp Zabel wrote:
> +config DRM_IMX_LDB
> +	tristate "Support for LVDS displays"
> +	help
> +	  Choose this to enable the internal LVDS Display Bridge (LDB)
> +	  found on i.MX53 and i.MX6 processors.
> +	depends on DRM_IMX
> +

Shouldn't we select OF_VIDEOMODE here, since of_get_drm_display_mode()
is called there.

Shawn
