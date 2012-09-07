From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:38:44 +0000
Subject: [PATCH v3 14/31] arm64: DMA mapping API
In-Reply-To: <1347035226-18649-15-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-15-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071938.44894.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch adds support for the DMA mapping API. It uses dma_map_ops for
> flexibility and it currently supports swiotlb. This patch could be
> simplified further if the DMA accesses are coherent (not mandated by the
> architecture) or if corresponding hooks are placed in the generic
> swiotlb code to deal with cache maintenance.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
