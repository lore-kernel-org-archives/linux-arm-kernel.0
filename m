From: joro@8bytes.org ('Joerg Roedel')
Date: Fri, 16 Dec 2011 15:15:07 +0100
Subject: [PATCH] iommu: Initialize domain->handler in iommu_domain_alloc()
In-Reply-To: <000401ccbbef$9b0389e0$d10a9da0$%cho@samsung.com>
References: <1323760466-30333-1-git-send-email-pullip.cho@samsung.com>
 <20111215081056.GC4475@8bytes.org>
 <000401ccbbef$9b0389e0$d10a9da0$%cho@samsung.com>
Message-ID: <20111216141507.GB28302@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 09:38:25PM +0900, KyongHo Cho wrote:
> Subject: [PATCH] iommu: Initialize domain->handler in iommu_domain_alloc()
> 
> Since it is not guaranteed that an iommu driver initializes in its
> domain_init() function, it must be initialized with NULL to prevent
> calling a function in an arbitrary location when iommu fault occurred.
> 
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>

Applied to iommu/fixes, thanks a lot.
