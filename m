From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 18:02:28 +0100
Subject: [PATCH v5 10/15] ARM: spectre-v2: warn about incorrect context
 switching functions
In-Reply-To: <E1fNg1d-00059d-NR@rmk-PC.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg1d-00059d-NR@rmk-PC.armlinux.org.uk>
Message-ID: <86r2lu9yzf.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 15:55:01 +0100,
Russell King wrote:
> 
> Warn at error level if the context switching function is not what we
> are expecting.  This can happen with big.Little systems, which we
> currently do not support.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Boot-tested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

I assume this is a temporary situation until the ARM port grows the
necessary infrastructure to support this mitigation on heterogeneous
systems. With that in mind:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
