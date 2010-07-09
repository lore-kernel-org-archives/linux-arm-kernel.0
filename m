From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 12:29:16 +0100
Subject: [PATCH v2 0/3] Ordered I/O accessors
In-Reply-To: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100709112915.GC22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 12:07:56PM +0100, Catalin Marinas wrote:
> This updated series fixes a bug in the L2x0 code causing a deadlock
> (thanks to Adrian Kwong at Trident). The solution is to convert the
> entire cache-l2x0.c file to the *_relaxed() I/O accessors.

Ok.
