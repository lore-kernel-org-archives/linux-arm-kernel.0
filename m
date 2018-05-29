From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 17:48:58 +0100
Subject: [PATCH v5 03/15] ARM: bugs: hook processor bug checking into SMP
 and suspend paths
In-Reply-To: <E1fNg12-000557-3p@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg12-000557-3p@rmk-PC.armlinux.org.uk>
Message-ID: <86y3g29zlx.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:54:24 +0100,
Russell King wrote:
> 
> Check for CPU bugs when secondary processors are being brought online,
> and also when CPUs are resuming from a low power mode.  This gives an
> opportunity to check that processor specific bug workarounds are
> correctly enabled for all paths that a CPU re-enters the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
