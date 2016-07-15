From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 15 Jul 2016 11:26:53 +0200
Subject: [PATCH] drm: mediatek: add Maintainers entry for Mediatek DRM
 drivers
In-Reply-To: <1468561924-45582-1-git-send-email-ck.hu@mediatek.com>
References: <1468561924-45582-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <1468574813.7213.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 15.07.2016, 13:52 +0800 schrieb CK Hu:
> Add CK Hu and Philipp Zabel as maintainers for Mediatek DRM drivers.
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  MAINTAINERS |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7304d2e..2a04cdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3973,6 +3973,14 @@ S:	Orphan / Obsolete
>  F:	drivers/gpu/drm/i810/
>  F:	include/uapi/drm/i810_drm.h
>  
> +DRM DRIVERS FOR MEDIATEK
> +M:	CK Hu <ck.hu@mediatek.com>
> +M:	Philipp Zabel <p.zabel@pengutronix.de>
> +L:	dri-devel at lists.freedesktop.org
> +S:	Supported
> +F:	drivers/gpu/drm/mediatek/
> +F:	Documentation/devicetree/bindings/display/mediatek/
> +
>  DRM DRIVER FOR MSM ADRENO GPU
>  M:	Rob Clark <robdclark@gmail.com>
>  L:	linux-arm-msm at vger.kernel.org

regards
Philipp
