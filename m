From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 20 Nov 2018 11:34:41 -0500
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
In-Reply-To: <20181120160818.GC2492@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de>
Message-ID: <20181120163441.GD31199@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 05:08:18PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018 at 02:09:51PM +0000, Robin Murphy wrote:
> > This is what I have so far, which at least resolves the most ovbious
> > problems. I still haven't got very far with the USB corruption issue
> > I see on Juno with -rc1, but I'm yet to confirm whether that's actually
> > attributable to the SWIOTLB changes or something else entirely.
> 
> This looks good modulo the minor nitpicks.
> 
> Konrad, are you ok with me picking up both through the dma-mapping
> tree?

Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
