From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Sep 2012 13:53:25 +0800
Subject: [PATCH 6/6] staging: drm/imx: Add TODO
In-Reply-To: <1347445874-10779-7-git-send-email-s.hauer@pengutronix.de>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120919055322.GI6460@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 12:31:14PM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/staging/imx-drm/TODO |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 drivers/staging/imx-drm/TODO
> 
> diff --git a/drivers/staging/imx-drm/TODO b/drivers/staging/imx-drm/TODO
> new file mode 100644
> index 0000000..2075646
> --- /dev/null
> +++ b/drivers/staging/imx-drm/TODO
> @@ -0,0 +1,22 @@
> +TODO:
> +- get DRM Maintainer review for this code
> +- Factor out more code to common helper functions
> +- decide where to put the base driver. It is not specific to a subsystem
> +  and would be used by DRM/KMS and media/V4L2
> +- convert irq driver to irq_domain_add_linear
> +
> +Missing features (not necessarily for moving out out staging):

out of?

> +
> +- Add KMS plane support for CRTC driver
> +- Add LDB (LVDS Display Bridge) support
> +- Add i.MX6 HDMI support
> +- Add support for IC (Image converter)
> +- Add support for CSI (CMOS Sensor interface)
> +- Add support for VDIC (Video Deinterlacer)
> +
> +Many work-in-progress patches for the above features exist. Contact
> +Sascha Hauer <kernel@pengutronix.de> if you are interested in working
> +on a specific feature.
> +
> +Please send any patches to Greg Kroah-Hartman <greg@kroah.com> and

Greg Kroah-Hartman <gregkh@linuxfoundation.org>?

> +Sascha Hauer <kernel@pengutronix.de>
> -- 
> 1.7.10.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
