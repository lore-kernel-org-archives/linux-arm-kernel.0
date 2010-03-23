From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:25:20 +0000
Subject: [PATCH v5 1/4] ARM: Move the outer_cache definitions into a
	separate file
In-Reply-To: <20100319143300.11748.75901.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
	<20100319143300.11748.75901.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323212520.GD19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 02:33:00PM +0000, Catalin Marinas wrote:
> To avoid #include collisions with subsequent patches in the series, this
> patch moves the outer_cache definitions to a separate asm/outercache.h
> file.

Ok.
