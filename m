From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 29 May 2015 14:43:45 +0530
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
In-Reply-To: <1432761820-32072-1-git-send-email-robert.jarzmik@free.fr>
References: <1432761820-32072-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150529091345.GE3140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 11:23:40PM +0200, Robert Jarzmik wrote:
> This fixes the following error:
> drivers/dma/pxa_dma.c: In function ?dbg_show_requester_chan?:
> drivers/dma/pxa_dma.c:192:2: error: void value not ignored as it ought to be
>   pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
>   ^
> drivers/dma/pxa_dma.c:197:8: error: void value not ignored as it ought to be
>         !!(drcmr & DRCMR_MAPVLD));
>         ^
> scripts/Makefile.build:258: recipe for target 'drivers/dma/pxa_dma.o' failed
Applied now, but not pleased that you sent broken code. Sending stuff that
compiles is basic step

-- 
~Vinod
