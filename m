From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Jun 2011 16:41:48 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
	to more generic alloc/free_attrs
In-Reply-To: <201106241753.49654.arnd@arndb.de>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<201106241753.49654.arnd@arndb.de>
Message-ID: <000b01cc34d8$58856820$09903860$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 24, 2011 5:54 PM Arnd Bergmann wrote:

> On Monday 20 June 2011, Marek Szyprowski wrote:
> > mmap method is introduced to let the drivers create a user space mapping
> > for a DMA buffer in generic, architecture independent way.
> 
> One more thing: please split out the mmap change into a separate patch.

Ok, no problem.

> I sense that there might be some objections to that, and it's better
> to let people know about it early on than having them complain
> later when that has already been merged.

Ok, I will also prepare much more detailed description for mmap patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
