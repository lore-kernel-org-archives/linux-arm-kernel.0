From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 14:38:05 +0800
Subject: [PATCH RFC 24/46] imx-drm: provide common connector mode
 validation function
In-Reply-To: <E1Vypnw-0007F7-EB@rmk-PC.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypnw-0007F7-EB@rmk-PC.arm.linux.org.uk>
Message-ID: <20140107063803.GB12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:27:48PM +0000, Russell King wrote:
> diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
> index 5649f180dc44..4eb594ce9cff 100644
> --- a/drivers/staging/imx-drm/imx-drm.h
> +++ b/drivers/staging/imx-drm/imx-drm.h
> @@ -68,4 +68,7 @@ int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
>  int imx_drm_encoder_add_possible_crtcs(struct imx_drm_encoder *imx_drm_encoder,
>  		struct device_node *np);
>  
> +int imx_drm_connector_mode_valid(struct drm_connector *connector,
> +	struct drm_display_mode *mode);
> +
>  #endif /* _IMX_DRM_H_ */

  CC      drivers/staging/imx-drm/ipu-v3/ipu-dc.o
  LD      net/ethernet/built-in.o
In file included from drivers/staging/imx-drm/ipu-v3/ipu-dc.c:23:0:
drivers/staging/imx-drm/ipu-v3/../imx-drm.h:56:9: warning: ?struct drm_display_mode? declared inside parameter list [enabled by default]
drivers/staging/imx-drm/ipu-v3/../imx-drm.h:56:9: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Shawn
