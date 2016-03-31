From: davem@davemloft.net (David Miller)
Date: Thu, 31 Mar 2016 15:15:42 -0400 (EDT)
Subject: [PATCH] net: mvpp2: replace MVPP2_CPU_D_CACHE_LINE_SIZE with
 L1_CACHE_BYTES
In-Reply-To: <1459338821-343-1-git-send-email-jszhang@marvell.com>
References: <1459338821-343-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160331.151542.1145855002785328972.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Wed, 30 Mar 2016 19:53:41 +0800

> The mvpp2 ip maybe used in SoCs which may have have 64bytes cacheline
> size. Replace the MVPP2_CPU_D_CACHE_LINE_SIZE with L1_CACHE_BYTES.
> 
> And since dma_alloc_coherent() is always cacheline size aligned, so
> remove the align checks.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied.
