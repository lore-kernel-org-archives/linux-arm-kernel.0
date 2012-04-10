From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 11:31:56 +0000
Subject: [PATCHv8 03/10] ARM: dma-mapping: introduce ARM_DMA_ERROR constant
In-Reply-To: <1334055852-19500-4-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101131.56412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> Replace all uses of ~0 with ARM_DMA_ERROR, what should make the code
> easier to read.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

I like the idea, but why not name this DMA_ERROR_CODE like the other
architectures do? I think in the long run we should put the definition
into a global header file.

	Arnd
