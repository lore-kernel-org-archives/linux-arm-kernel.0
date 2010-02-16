From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2010 23:11:52 +0000
Subject: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family files
In-Reply-To: <20100216192301.GQ21755@atomide.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
	<20100211181706.795.84644.stgit@localhost.localdomain>
	<alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com>
	<20100216192301.GQ21755@atomide.com>
Message-ID: <20100216231152.GA22618@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2010 at 11:23:01AM -0800, Tony Lindgren wrote:
> Just to comment on the naming, we should call additional cpu options
> CONFIG_CPU_OMAP3630 etc instead of CONFIG_ARCH_OMAP to avoid confusion.

Or CONFIG_SOC_OMAP3630.  OMAP3630 is not a CPU type - it's a description
of the whole system.  The CPU is just the processor and caches without
peripherals.
