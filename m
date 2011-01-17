From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:25:14 -0800
Subject: [PATCH 14/14] ARM: v6k: only allow SMP if we have v6k or v7 CPU
In-Reply-To: <E1Peui1-0003T9-6Q@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peui1-0003T9-6Q@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117232514.GM4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:25]:
> SMP extensions are only supported on ARMv6k or ARMv7 architectures, so
> only offer the option if we're building for such an architecture.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
