From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 18:03:06 +0100
Subject: [PATCH v5 13/15] ARM: spectre-v2: KVM: invalidate icache on guest
 exit for Brahma B15
In-Reply-To: <E1fNg1u-0005BA-3z@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg1u-0005BA-3z@rmk-PC.armlinux.org.uk>
Message-ID: <86po1e9yyd.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:55:18 +0100,
Russell King wrote:
> 
> Include Brahma B15 in the Spectre v2 KVM workarounds.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
