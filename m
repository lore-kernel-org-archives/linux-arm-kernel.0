From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 29 Jan 2018 11:58:00 +0200
Subject: [PATCH] drm/bridge: Rename argument from crtc to bridge
In-Reply-To: <20180129095531.4557-1-linus.walleij@linaro.org>
References: <20180129095531.4557-1-linus.walleij@linaro.org>
Message-ID: <2430917.BY1P9l4EpX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Monday, 29 January 2018 11:55:31 EET Linus Walleij wrote:
> Why is the argument to ->mode_valid() called "crtc"?
> I guess a copy/paste error. Fix it.

I confirm it's a mistake, so you can probably replace "guess" with a word 
carrying a bit more confidence :)

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/drm/drm_bridge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index bb7b97dfb93e..3270fec46979 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -91,7 +91,7 @@ struct drm_bridge_funcs {
>  	 *
>  	 * drm_mode_status Enum
>  	 */
> -	enum drm_mode_status (*mode_valid)(struct drm_bridge *crtc,
> +	enum drm_mode_status (*mode_valid)(struct drm_bridge *bridge,
>  					   const struct drm_display_mode *mode);
> 
>  	/**

-- 
Regards,

Laurent Pinchart
