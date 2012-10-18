From: marex@denx.de (Marek Vasut)
Date: Thu, 18 Oct 2012 12:51:14 +0200
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <507FC827.40601@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <201210181049.21556.marex@denx.de> <507FC827.40601@freescale.com>
Message-ID: <201210181251.15116.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2012?10?18? 16:49, Marek Vasut ??:
> > Dear Huang Shijie,
> > 
> >> ? 2012?10?18? 16:16, Marek Vasut ??:
> >>> So we can't stream data from the chip? About time to adjust the MTD
> >>> framework to allow that. Maybe implement a command queue?
> >> 
> >> IMHO, it's not possible. Because the READ-PAGE(00h-30h) command needs to
> >> check the busy status
> >> which means we have to stop in the middle, so we can not chain the all
> >> the read-pages DMA commands.
> > 
> > Can the DMA not branch?
> 
> it's too complicated to the MTD layer, as well as the gpmi driver.

Can you please elaborate ?

Best regards,
Marek Vasut
