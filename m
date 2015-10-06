From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Oct 2015 16:29:20 +0100
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <5611BBB5.9030403@samsung.com>
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
 <5611BBB5.9030403@samsung.com>
Message-ID: <5613E8D0.8050604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/15 00:52, Krzysztof Kozlowski wrote:
> On 03.10.2015 01:24, Marc Zyngier wrote:
>> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
>> it becomes possible to cleanup the open-coded versions of the same
>> macro that have been added to some private irqchips implementations.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mach-exynos/suspend.c       | 3 ++-
> 
> I guess you want to push it through the tip tree? If yes, then for Samsung:
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> (if not then please split it per mach)

I was more angling to have it directly picked up via arm-soc. But
otherwise yes, I can get it merged via tip if everyone agrees to it.

Splitting it per platform is a waste of time.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
