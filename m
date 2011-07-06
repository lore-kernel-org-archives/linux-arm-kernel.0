From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 16:37:04 +0100
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <007101cc3bec$dfbba8c0$9f32fa40$%szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<007101cc3bec$dfbba8c0$9f32fa40$%szyprowski@samsung.com>
Message-ID: <20110706153704.GF8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 04:56:23PM +0200, Marek Szyprowski wrote:
> This will not solve our problems. We need CMA also to create at least one
> device private area that for sure will be in low memory (video codec).

You make these statements but you don't say why.  Can you please
explain why the video codec needs low memory - does it have a
restricted number of memory address bits which it can manipulate?
