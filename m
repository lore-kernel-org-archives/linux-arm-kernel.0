From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 13 May 2010 08:57:06 +0200 (CEST)
Subject: [PATCH 9/9] ARM: add DMA support to sh7372, enable DMA for SDHI
In-Reply-To: <20100512155224.65eba9ee.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
	<Pine.LNX.4.64.1005041424330.4925@axis700.grange>
	<20100512155224.65eba9ee.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.1005130851030.4671@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 May 2010, Andrew Morton wrote:

> On Tue, 4 May 2010 16:07:15 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > This patch depends on patch series from Magnus for shmobile, adding INTC 
> > and clock support. This patch wasn't there in the first version of this 
> > series.
> 
> Where is that patch series now?

AFAIU, these are two patch series - for the interrupt controller and for 
the clock framework, and they are not upstream yet. So, I think, we can 
leave patch 9/9 for later to be merged via the respective platform tree.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
