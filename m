From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 28 Mar 2012 14:56:40 +1100
Subject: [PATCHv2 04/14] PowerPC: adapt for dma_map_ops changes
In-Reply-To: <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1332907000.2882.74.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-27 at 15:42 +0200, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Adapt core PowerPC architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> [added missing changes to arch/powerpc/kernel/vio.c]
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---

FYI. David and Arnd reviews are good enough for me ppc-side.

Cheers,
Ben.
