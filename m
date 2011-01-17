From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:15:22 -0800
Subject: [PATCH 07/14] ARM: v6k: select clear exclusive code seqences
	according to V6 variants
In-Reply-To: <E1Peufi-0003Sh-Ej@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peufi-0003Sh-Ej@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117231522.GF4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:27]:
> If CONFIG_CPU_V6 is enabled, then the kernel must support ARMv6 CPUs
> which don't have the V6K extensions implemented.  Always use the
> dummy store-exclusive method to ensure that the exclusive monitors are
> cleared.
> 
> If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, then we
> have the K extensions available on all CPUs we're building support for,
> so we can use the new clear-exclusive instruction.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
