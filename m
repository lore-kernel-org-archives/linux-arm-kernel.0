From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2011 15:38:57 -0800
Subject: [PATCH 41/41] ARM: restart: remove the now empty arch_reset()
In-Reply-To: <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
Message-ID: <20111110233857.GB31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:31]:
> Remove the now empty arch_reset() from all the mach/system.h includes,
> and remove its callsite.  Remove arm_machine_restart() as this function
> no longer does anything useful.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Assuming arch_reset can now also be removed for omaps:

Acked-by: Tony Lindgren <tony@atomide.com>
