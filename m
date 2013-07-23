From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:58:24 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0
In-Reply-To: <20130723011147.GA17885@verge.net.au>
References: <201307230218.01495.sergei.shtylyov@cogentembedded.com>
 <201307230223.24954.sergei.shtylyov@cogentembedded.com>
 <20130723011147.GA17885@verge.net.au>
Message-ID: <20130723015824.GJ16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 10:11:47AM +0900, Simon Horman wrote:
> On Tue, Jul 23, 2013 at 02:23:24AM +0400, Sergei Shtylyov wrote:
> > From: Max Filippov <max.filippov@cogentembedded.com>
> > 
> > Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
> > driver.
> > 
> > Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> > [Sergei: removed #include <mach/dma.h>]
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> I don't see HPBDMA_SLAVE_SDHI0_TX in v3.11-rc2.
> Please repost this patch when it is available in
> a branch I can used as a base.

Sorry, I now see it in patch 1/2.
Somehow I missed that :(
