From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:21:04 -0800
Subject: [PATCH 09/14] ARM: v6k: select generic atomic64 code according
	to V6 variants
In-Reply-To: <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117232104.GH4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> If CONFIG_CPU_V6 is enabled, avoid using the double-word exclusive
> instructions in the kernel's atomic implementations as these are not
> supported.  Fall back to the generic spinlock code instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
