From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:18:24 -0800
Subject: [PATCH 08/14] ARM: v6k: select cmpxchg code sequences
	according to V6 variants
In-Reply-To: <E1Peug2-0003Sl-IM@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peug2-0003Sl-IM@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117231823.GG4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> If CONFIG_CPU_V6 is enabled, we must avoid the byte/halfword/doubleword
> exclusive operations, which aren't implemented before V6K.  Use the
> generic versions (or omit them) instead.
> 
> If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, we have
> the K extnesions, so use these new instructions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
