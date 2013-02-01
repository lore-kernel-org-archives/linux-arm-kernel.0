From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 15:16:57 +0000
Subject: [PATCH V2 3/4] ARM: dts: Add #dma-cells for generic dma binding
 support
In-Reply-To: <1359723116-18173-4-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
 <1359723116-18173-4-git-send-email-padma.v@samsung.com>
Message-ID: <201302011516.57649.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Padmavathi Venna wrote:
> 
> This patch adds #dma-cells property to PL330 DMA controller
> nodes for supporting generic dma dt bindings on samsung
> exynos5250 platform.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

The generic binding also lists the dma-channels and dma-requests
properties. Those are currently not required by the code, but I think
it would be good to list them anyway, to be future-proof in case
we ever need them.

Otherwise

Acked-by: Arnd Bergmann <arnd@arndb.de>
