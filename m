From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 17:46:38 +0200 (CEST)
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <20100819153527.GE2985@suse.de>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
	<20100819153527.GE2985@suse.de>
Message-ID: <Pine.LNX.4.64.1008191744560.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Aug 2010, Greg KH wrote:

> On Thu, Aug 19, 2010 at 04:40:15PM +0200, Guennadi Liakhovetski wrote:
> > Allocate the bitmap in dma_declare_coherent_memory() together with the struct
> > dma_coherent_mem object.
> 
> You describe what you did, but _why_ are you doing it?

Well, to me the subject "_reduce_ the number..." is already a reason 
enough - the fewer kmalloc's of 20 bytes - the better, I think. But if you 
like, I can update the description too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
