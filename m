From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 10:59:34 +0100
Subject: [PATCH v4 07/10] ARM: Introduce MPIDR_LEVEL_SHIFT macro
In-Reply-To: <1473691764-29424-8-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-8-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3AB86.1020003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> vgic-v3 driver uses architecture specific MPIDR_LEVEL_SHIFT macro to
> encode the affinity in a form compatible with ICC_SGI* registers.
> Unfortunately, that macro is missing on ARM, so let's add it.
> 
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/cputype.h |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
