From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2011 17:53:49 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
In-Reply-To: <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201106241753.49654.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011, Marek Szyprowski wrote:
> mmap method is introduced to let the drivers create a user space mapping
> for a DMA buffer in generic, architecture independent way.

One more thing: please split out the mmap change into a separate patch.
I sense that there might be some objections to that, and it's better
to let people know about it early on than having them complain
later when that has already been merged.

	Arnd
