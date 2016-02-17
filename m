From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Feb 2016 11:02:44 +0900
Subject: [PATCH 11/11] iommu: exynos: add Maintainers entry for Exynos
 SYSMMU driver
In-Reply-To: <1455634624-18130-12-git-send-email-m.szyprowski@samsung.com>
References: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
 <1455634624-18130-12-git-send-email-m.szyprowski@samsung.com>
Message-ID: <56C3D4C4.20507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.2016 23:57, Marek Szyprowski wrote:
> Add Marek Szyprowski as maintainer for Exynos IOMMU driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7bd927e..1e9c4df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4336,6 +4336,12 @@ L:	dri-devel at lists.freedesktop.org
>  S:	Maintained
>  F:	drivers/gpu/drm/exynos/exynos_dp*
>  
> +EXYNOS SYSMMU (IOMMU) driver
> +M:	Marek Szyprowski <m.szyprowski@samsung.com>
> +L:	iommu at lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/iommu/exynos-iommu.c
> +
>  EXYNOS MIPI DISPLAY DRIVERS
>  M:	Inki Dae <inki.dae@samsung.com>
>  M:	Donghwa Lee <dh09.lee@samsung.com>
> 
