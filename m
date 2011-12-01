From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Dec 2011 16:29:17 +0900
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20111123114626.GH20535@8bytes.org>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
 <20111123114626.GH20535@8bytes.org>
Message-ID: <045b01ccaffa$ef48c430$cdda4c90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg Roedel wrote:
> 
> On Fri, Nov 18, 2011 at 06:47:28PM +0900, KyongHo Cho wrote:
> > Changes since v6:
> > - Totally rewrite exynos_iommu_map() and exynos_iommu_unmap() according
> >   to the change in iommu_map() and iommu_unmap().
> > - Change special slab for Lv2 page table to kmalloc().
> 
> Okay, the driver looks good to me now. If there are no further
> objections I am going to merge it for 3.3.
> 

Hi Joerg,

Sorry for late response, I came back just now from family travelling...

Anyway, that touches many Samsung stuff so it would be better if you could
create separate topic branch which can be merged into Samsung tree. And if
required, please add my ack on them.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
