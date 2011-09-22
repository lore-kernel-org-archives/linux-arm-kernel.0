From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Sep 2011 12:05:21 +0200
Subject: [RESEND PATCH 2/2] s5p-tv: Add PM_RUNTIME dependency
In-Reply-To: <1316670891-1672-1-git-send-email-hatim.rv@samsung.com>
References: <1316670891-1672-1-git-send-email-hatim.rv@samsung.com>
Message-ID: <005c01cc790f$24110fb0$6c332f10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, September 22, 2011 7:55 AM Hatim Ali wrote:

> The TVOUT driver requires PM_RUNTIME support for proper clock
> enabling.
> 
> Signed-off-by: Hatim Ali <hatim.rv@samsung.com>

I will take this patch to our v4l fixes branch. Thanks for your contribution.

> ---
>  drivers/media/video/s5p-tv/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/media/video/s5p-tv/Kconfig b/drivers/media/video/s5p-tv/Kconfig
> index 9c37dee..f2a0977 100644
> --- a/drivers/media/video/s5p-tv/Kconfig
> +++ b/drivers/media/video/s5p-tv/Kconfig
> @@ -8,7 +8,7 @@
> 
>  config VIDEO_SAMSUNG_S5P_TV
>  	bool "Samsung TV driver for S5P platform (experimental)"
> -	depends on PLAT_S5P
> +	depends on PLAT_S5P && PM_RUNTIME
>  	depends on EXPERIMENTAL
>  	default n
>  	---help---

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
