From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 29 May 2014 18:42:01 +0200
Subject: [PATCH] drm/exynos: hdmi: remove the i2c drivers and use devtree
 - continued
In-Reply-To: <1401381377-29973-1-git-send-email-lee.jones@linaro.org>
References: <1401381377-29973-1-git-send-email-lee.jones@linaro.org>
Message-ID: <53876359.8070304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On 29.05.2014 18:36, Lee Jones wrote:
> There appears to have been a merge error on commit:
> 
>   2b76813: drm/exynos: hdmi: remove the i2c drivers and use
> 
> The original submission can be found at:
> 
>   https://patchwork.kernel.org/patch/3559541/
> 
> It looks like the commit was only half applied.  This patch aims
> to finish what was started by Daniel.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/exynos/exynos_ddc.c     | 63 --------------------------------
>  drivers/gpu/drm/exynos/exynos_hdmi.h    | 23 ------------
>  drivers/gpu/drm/exynos/exynos_hdmiphy.c | 65 ---------------------------------
>  3 files changed, 151 deletions(-)
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_ddc.c
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmi.h
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy.c
> 

Obviously there is nothing to review, but still:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Thanks for the patch.

Best regards,
Tomasz
