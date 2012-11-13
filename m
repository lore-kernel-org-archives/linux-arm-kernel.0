From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Nov 2012 08:28:53 +0100
Subject: [PATCH] Fix typo in DT binding documentation for i.MX IPU3
In-Reply-To: <20121112223340.20867.75319.stgit@localhost.localdomain>
References: <20121112223340.20867.75319.stgit@localhost.localdomain>
Message-ID: <20121113072853.GY10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 11:33:40PM +0100, Martin Fuzzey wrote:
> crtc should be crtcs in parallel display.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

You might have to resend with Greg and dri-devel on Cc.

Sascha

> 
> ---
> 
>  .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> index 07654f0..68eff34 100644
> --- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> +++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> @@ -23,7 +23,7 @@ Parallel display support
>  
>  Required properties:
>  - compatible: Should be "fsl,imx-parallel-display"
> -- crtc: the crtc this display is connected to, see below
> +- crtcs: the crtc this display is connected to, see below
>  Optional properties:
>  - interface_pix_fmt: How this display is connected to the
>    crtc. Currently supported types: "rgb24", "rgb565"
> @@ -36,6 +36,6 @@ example:
>  display at di0 {
>  	compatible = "fsl,imx-parallel-display";
>  	edid = [edid-data];
> -	crtc = <&ipu 0>;
> +	crtcs = <&ipu 0>;
>  	interface-pix-fmt = "rgb24";
>  };
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
