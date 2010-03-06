From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 06 Mar 2010 10:02:19 +0000
Subject: [PATCH] ARM: Add omap-specific barrier implementation
In-Reply-To: <1267866784-10465-1-git-send-email-santosh.shilimkar@ti.com>
References: <1267866784-10465-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1267869739.4280.7.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-03-06 at 09:13 +0000, Santosh Shilimkar wrote:
> This patch defines ARCH_HAS_BARRIERS for the OMAP4 platform if
> CACHE_L2X0 is enabled and adds the mach/barriers.h file. The mb() and
> wmb() barriers perform an L2 cache sync in addition to the DSB.
> 
> The patch is based on top of Catalin's below series
>         - [PATCH v3 0/4] ARM mandatory barriers
>         - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/75425
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

If Russell's ok with getting these patches merged (most likely during
the next merging window), your patch is fine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
