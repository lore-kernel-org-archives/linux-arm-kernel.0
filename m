From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 22:37:05 +0000
Subject: [PATCH 1/2] ARM: exynos: pl330: Add #dma-cells for generic dma
 binding support
In-Reply-To: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
References: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
Message-ID: <201303052237.05910.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 March 2013, Padmavathi Venna wrote:
> 
> This patch adds #dma-cells property to PL330 DMA controller
> nodes for supporting generic dma dt bindings on samsung exynos
> platforms. #dma-channels and #dma-requests are not required now
> but added in advance.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should we apply these directly to the arm-soc fixes branch, or wait
until they come back from the Samsung subarchitecture tree?
