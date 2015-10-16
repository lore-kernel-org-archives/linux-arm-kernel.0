From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Oct 2015 17:20:43 +0100
Subject: [PATCH 1/2] arm64: Workaround renaming of __GFP_WAIT
In-Reply-To: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
Message-ID: <20151016162043.GF6613@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 04:33:41PM +0100, Robin Murphy wrote:
> The imminent renaming of __GFP_WAIT in the mm tree conflicts with its
> use in the new IOMMU DMA ops; introduce a temporary local version of
> its replacement to smooth over the transition.
> 
> This patch should be reverted at 4.4-rc1.
> 
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
