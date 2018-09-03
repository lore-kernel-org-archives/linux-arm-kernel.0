From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 3 Sep 2018 14:18:45 +0200
Subject: [PATCH 10/27] drm/sun4i: Add compatible for H6 display engine
In-Reply-To: <20180902072643.4917-11-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-11-jernej.skrabec@siol.net>
Message-ID: <20180903121845.znqhufx24ihcpmkn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Sun, Sep 02, 2018 at 09:26:26AM +0200, Jernej Skrabec wrote:
> H6 is first Allwinner SoC which supports 10 bit colors, HDR and AFBC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index dd19d674055c..e5731d092e1a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -410,6 +410,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id sun4i_drv_of_table[] = {
>  	{ .compatible = "allwinner,sun4i-a10-display-engine" },
> +	{ .compatible = "allwinner,sun50i-h6-display-engine" },
>  	{ .compatible = "allwinner,sun5i-a10s-display-engine" },
>  	{ .compatible = "allwinner,sun5i-a13-display-engine" },
>  	{ .compatible = "allwinner,sun6i-a31-display-engine" },

While it makes sens from an alphabetical point of view, we usually
follow the number order here (so after sun9i).

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180903/b60766eb/attachment-0001.sig>
