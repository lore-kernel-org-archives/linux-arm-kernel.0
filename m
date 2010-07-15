From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jul 2010 13:56:47 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
References: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
Message-ID: <1279198607.6664.20.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-15 at 13:52 +0100, David Yang wrote:
> the patch v3 2/3 can not be patched to my  arch/arm/mm/cache-l2x0.c
> from linux-2.6.33-arm1
> 
> should I modify it manually?

It's just a simple replacement - s/writel/writel_relaxed/

-- 
Catalin
