From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 17:50:00 +0100
Subject: [PATCH v5 04/15] ARM: bugs: add support for per-processor bug
 checking
In-Reply-To: <E1fNg17-00055G-7W@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg17-00055G-7W@rmk-PC.armlinux.org.uk>
Message-ID: <86wovm9zk7.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:54:29 +0100,
Russell King wrote:
> 
> Add support for per-processor bug checking - each processor function
> descriptor gains a function pointer for this check, which must not be
> an __init function.  If non-NULL, this will be called whenever a CPU
> enters the kernel via which ever path (boot CPU, secondary CPU startup,
> CPU resuming, etc.)
> 
> This allows processor specific bug checks to validate that workaround
> bits are properly enabled by firmware via all entry paths to the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
