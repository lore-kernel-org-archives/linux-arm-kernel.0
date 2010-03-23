From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:25:42 +0000
Subject: [PATCH v5 2/4] ARM: Add outer_cache_fns.sync function pointer
In-Reply-To: <20100319143306.11748.81315.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
	<20100319143306.11748.81315.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323212542.GE19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 02:33:06PM +0000, Catalin Marinas wrote:
> This patch introduces the outer_cache_fns.sync function pointer together
> with the OUTER_CACHE_SYNC config option that can be used to drain the
> write buffer of the outer cache.

Ok.
