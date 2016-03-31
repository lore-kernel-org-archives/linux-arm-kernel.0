From: davem@davemloft.net (David Miller)
Date: Thu, 31 Mar 2016 15:15:47 -0400 (EDT)
Subject: [PATCH] net: mvneta: replace MVNETA_CPU_D_CACHE_LINE_SIZE with
 L1_CACHE_BYTES
In-Reply-To: <1459338921-391-1-git-send-email-jszhang@marvell.com>
References: <1459338921-391-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160331.151547.1889188465826831929.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Wed, 30 Mar 2016 19:55:21 +0800

> The mvneta is also used in some Marvell berlin family SoCs which may
> have 64bytes cacheline size. Replace the MVNETA_CPU_D_CACHE_LINE_SIZE
> usage with L1_CACHE_BYTES.
> 
> And since dma_alloc_coherent() is always cacheline size aligned, so
> remove the align checks.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied.
