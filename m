From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 12:21:40 +0000
Subject: [PATCHv8 09/10] ARM: dma-mapping: use alloc, mmap,
 free from dma_ops
In-Reply-To: <1334055852-19500-10-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101221.41282.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch converts dma_alloc/free/mmap_{coherent,writecombine}
> functions to use generic alloc/free/mmap methods from dma_map_ops
> structure. A new DMA_ATTR_WRITE_COMBINE DMA attribute have been
> introduced to implement writecombine methods.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
