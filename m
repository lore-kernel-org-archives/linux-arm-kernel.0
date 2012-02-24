From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 15:48:59 +0000
Subject: [PATCH 00/14] DMA-mapping framework redesign preparation
In-Reply-To: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201202241548.59791.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 December 2011, Marek Szyprowski wrote:
> The solution we found is to introduce a new public dma mapping functions
> with additional attributes argument: dma_alloc_attrs and
> dma_free_attrs(). This way all different kinds of architecture specific
> buffer mappings can be hidden behind the attributes without the need of
> creating several versions of dma_alloc_ function.

Since the patches are now in linux-next, we should make sure that they
can actually get merged into 3.4.

I've looked at all the patches again and found them to be straightforward
and helpful, I hope we can get them merged next time. Please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
