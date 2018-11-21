From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 14:03:31 +0100
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
In-Reply-To: <20181120163441.GD31199@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com>
Message-ID: <20181121130331.GA1373@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > Konrad, are you ok with me picking up both through the dma-mapping
> > tree?
> 
> Yes, albeit I would want Stefano to take a peek at patch #2 just in case.

Stefano, can you take a look asap?  This is a pretty trivial fix for
a nasty bug that breaks boot on real life systems.  I'd like to merge
it by tomorrow so that I can send it off to Linus for the next rc
(I will be offline for about two days after Friday morning)
