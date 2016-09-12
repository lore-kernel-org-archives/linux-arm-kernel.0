From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Sep 2016 10:18:15 +0100
Subject: [PATCH 21/20] drm/exynos: Fix iommu_dma_init_domain prototype
 change
In-Reply-To: <47cdafe035630f29aa1e8ff121c5a5306a2f1eb2.1473444220.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
 <47cdafe035630f29aa1e8ff121c5a5306a2f1eb2.1473444220.git.robin.murphy@arm.com>
Message-ID: <20160912091814.GC23211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:17:46PM +0100, Robin Murphy wrote:
> When adding an extra argument to a function, one really should try a bit
> harder to catch *all* the callers...
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: David Airlie <airlied@linux.ie>
> CC: dri-devel at lists.freedesktop.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> Ideally, this should be squashed into "iommu/dma: Avoid PCI host bridge
> windows" to avoid potential bisection breakage. Sorry!

I'll squash this in when I push out the final series..

Will
