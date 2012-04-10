From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 12:24:24 +0000
Subject: [PATCHv8 07/10] ARM: dma-mapping: move all dma bounce code to
 separate dma ops structure
In-Reply-To: <1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101224.24959.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch removes dma bounce hooks from the common dma mapping
> implementation on ARM architecture and creates a separate set of
> dma_map_ops for dma bounce devices.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

I could be misunderstanding something, but it looks like this
one should come before patch 6, where you remove
some of the dmabounce functions. Can you clarify?

	Arnd
