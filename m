From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jun 2011 09:04:57 +0100
Subject: [RFC PATCH 12/16] ARM: watchdog: make mpcore_wdt independant
	from asm/smp_twd.h
In-Reply-To: <20110617070825.GI23305@infomag.iguana.be>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<1308251204-16719-13-git-send-email-marc.zyngier@arm.com>
	<20110617070825.GI23305@infomag.iguana.be>
Message-ID: <4DFB0AA9.4070606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/11 08:08, Wim Van Sebroeck wrote:
> Hi Marc,
> 
>> As the life expectancy of asm/smp_twd.h seems rather limited,
>> move the few defines concerning mpcore_wdt to the driver itself.
>>
>> Change the dependency to ARM_SMP_TWD as well.
>>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> I presume you Will keep this patch together with the other patches?

Most probably, though it is fairly independent from the whole series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
