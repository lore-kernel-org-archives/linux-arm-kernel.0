From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 14:07:17 +0200
Subject: [PATCHv11 0/8] Contiguous Memory Allocator
In-Reply-To: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201107051407.17249.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Marek Szyprowski wrote:
> This is yet another round of Contiguous Memory Allocator patches. I hope
> that I've managed to resolve all the items discussed during the Memory
> Management summit at Linaro Meeting in Budapest and pointed later on
> mailing lists. The goal is to integrate it as tight as possible with
> other kernel subsystems (like memory management and dma-mapping) and
> finally merge to mainline.

You have certainly addressed all of my concerns, this looks really good now!

Andrew, can you add this to your -mm tree? What's your opinion on the
current state, do you think this is ready for merging in 3.1 or would
you want to have more reviews from core memory management people?

My reviews were mostly on the driver and platform API side, and I think
we're fine there now, but I don't really understand the impacts this has
in mm.

	Arnd
