From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jan 2012 15:31:40 +0000
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201201261531.40551.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 January 2012, Marek Szyprowski wrote:
> Welcome everyone!
> 
> Yes, that's true. This is yet another release of the Contiguous Memory
> Allocator patches. This version mainly includes code cleanups requested
> by Mel Gorman and a few minor bug fixes.

Hi Marek,

Thanks for keeping up this work! I really hope it works out for the
next merge window.

> TODO (optional):
> - implement support for contiguous memory areas placed in HIGHMEM zone
> - resolve issue with movable pages with pending io operations

Can you clarify these? I believe the contiguous memory areas in highmem
is something that should really be after the existing code is merged
into the upstream kernel and should better not be listed as TODO here.

I haven't followed the last two releases so closely. It seems that
in v17 the movable pages with pending i/o was still a major problem
but in v18 you added a solution. Is that right? What is still left
to be done here then?

	Arnd
