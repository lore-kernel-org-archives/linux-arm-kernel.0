From: robert.jarzmik@free.fr (robert.jarzmik at free.fr)
Date: Fri, 29 May 2015 11:29:09 +0200 (CEST)
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
In-Reply-To: <20150529091345.GE3140@localhost>
Message-ID: <1617548760.717381111.1432891749082.JavaMail.root@zimbra1-e1.priv.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Mail original -----
De: "Vinod Koul" <vinod.koul@intel.com>
?: "Robert Jarzmik" <robert.jarzmik@free.fr>

On Wed, May 27, 2015 at 11:23:40PM +0200, Robert Jarzmik wrote:
> This fixes the following error:
> drivers/dma/pxa_dma.c: In function ?dbg_show_requester_chan?:
> drivers/dma/pxa_dma.c:192:2: error: void value not ignored as it ought to be
>   pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
> Applied now.
Thanks.

> but not pleased that you sent broken code. Sending stuff that
> compiles is basic step
You should know me better by now. I told you I compiled *and* tested.

And with a a bit closer look check this commit, especially the date :
commit 0bac33653b06a5f80a5c04e275eb33db9493b85a
Author: Joe Perches <joe@perches.com>
Date:   Sat May 23 12:00:38 2015 +1000

    fs/seq_file: convert int seq_vprint/seq_printf/etc... returns to void

Cheers.

--
Robert
