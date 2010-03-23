From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:25:58 +0000
Subject: [PATCH v5 3/4] ARM: Add L2x0 outer_sync() support
In-Reply-To: <20100319143311.11748.76264.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
	<20100319143311.11748.76264.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323212558.GF19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 02:33:11PM +0000, Catalin Marinas wrote:
> The L2x0 cache controllers need to explicitly drain their write buffer
> even for Normal Noncacheable memory accesses.

Ok.
