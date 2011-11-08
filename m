From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 8 Nov 2011 15:48:35 +0000
Subject: [PATCH 41/41] ARM: restart: remove the now empty arch_reset()
In-Reply-To: <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
Message-ID: <20111108154835.GF4405@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 06, 2011 at 05:53:51PM +0000, Russell King - ARM Linux wrote:
> Remove the now empty arch_reset() from all the mach/system.h includes,
> and remove its callsite.  Remove arm_machine_restart() as this function
> no longer does anything useful.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
