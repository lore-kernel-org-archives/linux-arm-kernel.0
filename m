From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 23 Nov 2011 12:46:27 +0100
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <20111123114626.GH20535@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 06:47:28PM +0900, KyongHo Cho wrote:
> Changes since v6:
> - Totally rewrite exynos_iommu_map() and exynos_iommu_unmap() according
>   to the change in iommu_map() and iommu_unmap().
> - Change special slab for Lv2 page table to kmalloc().

Okay, the driver looks good to me now. If there are no further
objections I am going to merge it for 3.3.


	Joerg
