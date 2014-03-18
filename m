From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Mar 2014 15:58:36 +0100
Subject: [PATCH RESEND v2 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <20140317144235.546d2e19@marrow.netinsight.se>
References: <20140317144016.0508cc4d@marrow.netinsight.se>
 <20140317144235.546d2e19@marrow.netinsight.se>
Message-ID: <201403181558.37094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014, Simon K?gstr?m wrote:
> Non-PCI devices can use the entire 32-bit range, PCI dittos are
> limited to the first 64MiB.
> 
> Also actually setup coherent_dma_mask.
> 
> The patch has been verified on a board with 128MiB memory, one
> ipx4xx_eth device and a e100 PCI device.
> 
> Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
> ---

I've applied this patch to the next/fixes-non-critical branch of arm-soc.
Please let me know if you need to have it backported to older kernels
as well.

Patch 2 should go through the netdev tree.

	Arnd
