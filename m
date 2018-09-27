From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Sep 2018 12:13:47 +0200
Subject: [PATCH] drm/rockchip: typo: selet->select
In-Reply-To: <20180923142005.23915-1-hanetzer@startmail.com>
References: <20180923142005.23915-1-hanetzer@startmail.com>
Message-ID: <7004894.1MZhX1FFyX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

Am Sonntag, 23. September 2018, 16:20:05 CEST schrieb Marty E. Plummer:
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0ccc76217ee4..7d1ccc9efc76 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
>  	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the Analogix Core DP driver. If you want to enable DP
> -	  on RK3288 based SoC, you should selet this option.
> +	  on RK3288 based SoC, you should select this option.

The "selet" typos got fixed in another commit recently.
dc879f61c45d  ("drm/rockchip: fix coding style and incorrect description")
from Sandy on 2018-08-28.

It is sitting on drm-misc-next [0] waiting for the next merge-window.

Heiko

[0] https://cgit.freedesktop.org/drm/drm-misc/log/
