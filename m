From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Feb 2014 15:31:17 +0900
Subject: [PATCH] ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
In-Reply-To: <20140205053628.29078.92360.sendpatchset@w520>
References: <20140205053628.29078.92360.sendpatchset@w520>
Message-ID: <20140206063115.GA13435@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:36:28PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Some on-chip devices on r8a7790 and r8a7791 can do
> bus mastering and access more than 32-bits of address
> space. Select ARCH_DMA_ADDR_T_64BIT when LPAE is set
> in case of multiplatform and legacy SoC support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
