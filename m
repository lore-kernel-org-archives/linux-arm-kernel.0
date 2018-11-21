From: cl@linux.com (Christopher Lameter)
Date: Wed, 21 Nov 2018 17:38:30 +0000
Subject: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
In-Reply-To: <20181121164638.GD24883@arm.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org>
 <20181121164638.GD24883@arm.com>
Message-ID: <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2018, Will Deacon wrote:

> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32

SLAB_CACHE_DMA32??? WTH is going on here? We are trying to get rid of
the dma slab array.
