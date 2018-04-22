From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 22 Apr 2018 11:43:28 +0530
Subject: [PATCH 01/15] dmaengine: pxa: use a dma slave map
In-Reply-To: <87604kz7mu.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-2-robert.jarzmik@free.fr>
 <87604kz7mu.fsf@belgarion.home>
Message-ID: <20180422061328.GT6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 09:23:05PM +0200, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > In order to remove the specific knowledge of the dma mapping from PXA
> > drivers, add a default slave map for pxa architectures.
> >
> > This won't impact MMP architecture, but is aimed only at all PXA boards.
> >
> > This is the first step, and once all drivers are converted,
> > pxad_filter_fn() will be made static, and the DMA resources removed from
> > device.c.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> Vinod, could I have your ack please ?

Sure thing:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
