From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jan 2013 10:49:30 +0000
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50F61D86.4020801@web.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <20130116024014.GH25500@titan.lakedaemon.net> <50F61D86.4020801@web.de>
Message-ID: <201301171049.30415.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 January 2013, Soeren Moch wrote:
> >> I will see what I can do here. Is there an easy way to track the buffer
> >> usage without having to wait for complete exhaustion?
> >
> > DMA_API_DEBUG
> 
> OK, maybe I can try this.
> >

Any success with this? It should at least tell you if there is a
memory leak in one of the drivers.

	Arnd
