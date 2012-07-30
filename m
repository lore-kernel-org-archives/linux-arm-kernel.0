From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 30 Jul 2012 08:48:30 -0000
Subject: [PATCH 3/3] driver: Include the modified FIMD header file
In-Reply-To: <1343637905-17764-4-git-send-email-l.krishna@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-4-git-send-email-l.krishna@samsung.com>
Message-ID: <CAL1wa8fDhZ1pqvxOFsm+jG4rd8HRobGg-2NHh0TeAjmB-=kHow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Marek

On Mon, Jul 30, 2012 at 2:15 PM, Leela Krishna Amudala <
l.krishna@samsung.com> wrote:

> The fimd register headers have been moved to include/video/
> hence, modifying the driver files accordingly.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c |    2 +-
>  drivers/video/s3c-fb.c                   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index 29fdbfe..8da90f9 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -20,7 +20,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include <drm/exynos_drm.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
>
>  #include "exynos_drm_drv.h"
>  #include "exynos_drm_fbdev.h"
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 69bf9d0..1226fdd 100644
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
>  /* This driver will export a number of framebuffer interfaces depending
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120730/e19f6a8b/attachment-0001.html>
