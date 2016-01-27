From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 27 Jan 2016 21:40:57 +0530
Subject: [PATCH v3] ARM: edma: fix residue race for cyclic
In-Reply-To: <56A8D0CA.9060307@ti.com>
References: <87oacesxzy.fsf@linutronix.de>
 <56A8D0CA.9060307@ti.com>
Message-ID: <20160127161057.GY11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:14:34PM +0200, Peter Ujfalusi wrote:
> One nitpick

One more...

> >  drivers/dma/edma.c |   40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)

And I happily ignored these patches as title said ARM: edma ... Whereas it
should have said dmaengine.

Please use the proper subsystem styles otherwise your patches will get
ignored..

-- 
~Vinod
