From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Aug 2012 11:20:35 +0900
Subject: [PATCH V2 4/5] driver: Include the modified FIMD header file
In-Reply-To: <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
Message-ID: <02f601cd6f8c$3c9b55d0$b5d20170$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leela Krishna Amudala wrote:
> 
> The fimd register headers have been moved to include/video/
> hence, modifying the driver files accordingly.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c |    2 +-
>  drivers/video/s3c-fb.c                   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

[...]

> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -26,7 +26,7 @@
>  #include <linux/pm_runtime.h>
> 
>  #include <mach/map.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
>  #include <plat/fb.h>
> 
See my previous comments.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
