From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 30 May 2014 09:14:03 +0100
Subject: [PATCH] drm/exynos: remove unnecessary exynos_hdmi.h file
In-Reply-To: <000a01cf7bac$8f805f60$ae811e20$%han@samsung.com>
References: <000a01cf7bac$8f805f60$ae811e20$%han@samsung.com>
Message-ID: <20140530081403.GD2619@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The exynos_hdmi.h has been used for the dedicated i2c drivers
> that were already removed. Thus, the unnecessary exynos_hdmi.h
> should be removed.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.h |   23 -----------------------
>  1 file changed, 23 deletions(-)
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmi.h

https://lkml.org/lkml/2014/5/29/810

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
