From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 08:59:49 +0000
Subject: [PATCH] dma: amba-pl08x: Export pl08x_filter_id
In-Reply-To: <1345107396-27079-1-git-send-email-stigge@antcom.de>
References: <1345107396-27079-1-git-send-email-stigge@antcom.de>
Message-ID: <201208160859.49317.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Roland Stigge wrote:
> This patch fixes the following when compiling a driver module that uses
> amba-pl08x:
> 
> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_slc.ko] undefined!
> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_mlc.ko] undefined!
> 
> (drivers/mtd/nand/lpc32xx_* are still in l2-mtd.git)
> 
> Done as in:
> 
> drivers/dma/coh901318.c
> drivers/dma/sirf-dma.c
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
