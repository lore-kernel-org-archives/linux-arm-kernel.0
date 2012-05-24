From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 24 May 2012 21:28:54 +0900
Subject: [PATCHv2 3/4] mm: vmalloc: add VM_DMA flag to indicate areas
 used by dma-mapping framework
In-Reply-To: <01e501cd39a8$67f34ea0$37d9ebe0$%szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-4-git-send-email-m.szyprowski@samsung.com>
 <4FBB3B41.8010102@kernel.org>
 <01e501cd39a8$67f34ea0$37d9ebe0$%szyprowski@samsung.com>
Message-ID: <20120524122854.GD11860@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 02:26:12PM +0200, Marek Szyprowski wrote:
> On Tuesday, May 22, 2012 9:08 AM Minchan Kim wrote:
> > Hmm, VM_DMA would become generic flag?
> > AFAIU, maybe VM_DMA would be used only on ARM arch.
> 
> Right now yes, it will be used only on ARM architecture, but maybe other architecture will
> start using it once it is available.
> 
There's very little about the code in question that is ARM-specific to
begin with. I plan to adopt similar changes on SH once the work has
settled one way or the other, so we'll probably use the VMA flag there,
too.
