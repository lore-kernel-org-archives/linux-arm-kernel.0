From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 12:22:23 +0000
Subject: [PATCHv8 08/10] ARM: dma-mapping: remove redundant code and
 cleanup
In-Reply-To: <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101222.23522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> 
> This patch just performs a global cleanup in DMA mapping implementation
> for ARM architecture. Some of the tiny helper functions have been moved
> to the caller code, some have been merged together.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
