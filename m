From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 17:52:27 +0100
Subject: [PATCH v5 06/15] ARM: spectre-v2: harden branch predictor on
 context switches
In-Reply-To: <E1fNg1H-00055Y-W1@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg1H-00055Y-W1@rmk-PC.armlinux.org.uk>
Message-ID: <86tvqq9zg4.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:54:39 +0100,
Russell King wrote:
> 
> Harden the branch predictor against Spectre v2 attacks on context
> switches for ARMv7 and later CPUs.  We do this by:
> 
> Cortex A9, A12, A17, A73, A75: invalidating the BTB.
> Cortex A15, Brahma B15: invalidating the instruction cache.
> 
> Cortex A57 and Cortex A72 are not addressed in this patch.
> 
> Cortex R7 and Cortex R8 are also not addressed as we do not enforce
> memory protection on these cores.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
