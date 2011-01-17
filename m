From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:14:37 -0800
Subject: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
In-Reply-To: <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117231437.GE4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:29]:
> Introduce a CPU_V6K configuration option for platforms to select if they
> have a V6K CPU core.  This allows us to identify whether we need to
> support ARMv6 CPUs without the V6K SMP extensions at build time.
> 
> Currently CPU_V6K is just an alias for CPU_V6, and all places which
> reference CPU_V6 are replaced by (CPU_V6 || CPU_V6K).
> 
> Select CPU_V6K from platforms which are known to be V6K-only.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
