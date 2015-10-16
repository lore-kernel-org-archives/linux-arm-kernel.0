From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Oct 2015 17:20:56 +0100
Subject: [PATCH 2/2] arm64: Use gfpflags_allow_blocking()
In-Reply-To: <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
 <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
Message-ID: <20151016162056.GG6613@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 04:33:42PM +0100, Robin Murphy wrote:
> __GFP_WAIT is going away to live its life under a new identity; convert
> __iommu_alloc_attrs() to the new helper function instead.
> 
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
