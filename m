From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 13 Jan 2015 16:02:08 +0800
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <cover.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Message-ID: <1421136128.27675.58.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-12 at 20:48 +0000, Robin Murphy wrote:
> Hi all,
> 
> Whilst it's a long way off perfect, this has reached the point of being
> functional and stable enough to be useful, so here it is. The core
> consists of the meat of the arch/arm implementation modified to remove
> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
> allocator instead of the bitmap-based one. For that, this series depends
> on my "Genericise the IOVA allocator" series posted earlier[1].

Hi Robin,

We'd to give it a try. Do you have a public git tree contains both
series?

Joe.C
