From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 13:30:35 +0100
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <201107051427.44899.arnd@arndb.de>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-7-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<201107051427.44899.arnd@arndb.de>
Message-ID: <20110705123035.GD8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:27:44PM +0200, Arnd Bergmann wrote:
> It's also a preexisting problem as far as I can tell, and it needs
> to be solved in __dma_alloc for both cases, dma_alloc_from_contiguous
> and __alloc_system_pages as introduced in patch 7.

Which is now resolved in linux-next, and has been through this cycle
as previously discussed.

It's taken some time because the guy who tested the patch for me said
he'd review other platforms but never did, so I've just about given up
waiting and stuffed it in ready for the 3.1 merge window irrespective
of anything else.
