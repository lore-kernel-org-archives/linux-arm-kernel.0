From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 20 Nov 2012 11:52:22 -0800
Subject: [PATCH] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50AB600C.5010801@samsung.com>
References: <1352356737-14413-1-git-send-email-m.szyprowski@samsung.com>
 <20121119001846.GB22106@titan.lakedaemon.net>
 <20121119144826.f59667b2.akpm@linux-foundation.org>
 <50AB600C.5010801@samsung.com>
Message-ID: <20121120115222.9b674d86.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2012 11:48:44 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > As this patch is already in -next and is stuck there for two more
> > weeks I can't (or at least won't) merge this patch, so I can't help
> > with any of the above.
> 
> I will fix both issues in the next version of the patch. Would like to
> merge it to your tree or should I keep it in my dma-mapping tree?

The patch looks OK to me now (still wondering about the -stable
question though).

It would be a bit of a pain for me to carry a patch which conflicts
with one in linux-next, and this patch doesn't appear to conflict with
the other pending dmapool.c patches in -mm so you may as well keep it
in the dma-mapping tree now.
