From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Sep 2016 16:38:45 +0200 (CEST)
Subject: [PATCH v6.1] iommu/dma: Add support for mapping MSIs
In-Reply-To: <33fb440d91a5fe8c3e7dc8a5e12d83a5253911dd.1473242018.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
 <2da5fca62886afd46cd2a5f7da1da872ee4a833d.1473173789.git.robin.murphy@arm.com>
 <33fb440d91a5fe8c3e7dc8a5e12d83a5253911dd.1473242018.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.20.1609091638060.5679@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2016, Robin Murphy wrote:
> - Rework map_page() helper function plus insane lookup logic into
>   straightforward get_page() helper
> - Use phys_addr_t to further simplify address matching
> - Fix the bit where I neglected to actually round the doorbell
>   address to a page boundary (oops!)
> - Make the locking hardirq-safe to satisfy lockdep

That looks way better.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
