From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 18:03:56 +0100
Subject: [PATCH v5 14/15] ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast
 handling
In-Reply-To: <E1fNg1z-0005C1-92@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg1z-0005C1-92@rmk-PC.armlinux.org.uk>
Message-ID: <86o9gy9ywz.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:55:23 +0100,
Russell King wrote:
> 
> We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
> So let's intercept it as early as we can by testing for the
> function call number as soon as we've identified a HVC call
> coming from the guest.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
