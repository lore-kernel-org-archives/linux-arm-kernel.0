From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 4 Feb 2015 15:21:49 +0100
Subject: [PATCH v5 00/18] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150204142149.GM3702@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Jan 23, 2015 at 04:51:10PM +0100, Marek Szyprowski wrote:
> 1. All iommu related patches (with 'iommu: exynos') can be merged to
> iommu tree. They don't have any direct dependencies on the DTS, DRM and
> power domain initialization change - without them the driver will simply
> not initialize, when no exynos,sysmmu nodes are provided in device tree.
> 
> Joerg, could you merge those patches?

Given the previous comments and tests on this patch set I am still
waiting for some Acked-bys and/or Tested-bys on this. Can you collect
these and resend then (probably after the v3.20 merge window)?


	Joerg
