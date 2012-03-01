From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Mar 2012 11:40:27 +0100
Subject: [PATCH v9 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <001801ccf5e3$69d79860$3d86c920$%cho@samsung.com>
References: <001801ccf5e3$69d79860$3d86c920$%cho@samsung.com>
Message-ID: <00fe01ccf797$b7ced690$276c83b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday, February 28, 2012 7:37 AM KyongHo Cho wrote:

> Changes since v8:
> - exynos_iommu_map/unmap() just works for the page sizes
>    that System MMU supports. (Joerg's comment)
> - 1 platform device for 1 H/W though a multimedia accelerator
>    with several System MMUs attached.
>    This make controlling System MMU simpler.
> - Information between System MMU and the accelerators:
>    Shifted to accelerator's device structure from System MMU's

Could you tell which kernel tree did you use as a base for this patch? 

It doesn't apply onto any of the known kernel trees (I've tried v3.2, v3.3-rc5 and
kgene/for-next). It looks that you have used some internal tree because cannot 
find arch/arm/mach-exynos/clock-exynos5.c or arch/arm/mach-exynos/clock-exynos4212.c
files in any of the public git repositories. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
