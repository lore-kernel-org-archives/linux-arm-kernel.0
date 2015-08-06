From: joro@8bytes.org (joro at 8bytes.org)
Date: Thu, 6 Aug 2015 19:54:39 +0200
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <20150806152327.GH25483@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
 <20150806152327.GH25483@arm.com>
Message-ID: <20150806175439.GS14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Aug 06, 2015 at 04:23:27PM +0100, Will Deacon wrote:
> We're quite keen to get this in for arm64, since we're without IOMMU DMA
> ops and need to get something upstream. Do you think this is likely to
> be merged for 4.3/4.4 or would we be better off doing our own
> arch-private implementation instead?
> 
> Sorry to pester, but we've got people basing their patches and products
> on this and I don't want to end up having to support out-of-tree code.

I definitly plan to merge it soon, but not sure if its getting into
v4.3. There are a few things I have questions about or need rework, but
I am sure we can work this out.


	Joerg
