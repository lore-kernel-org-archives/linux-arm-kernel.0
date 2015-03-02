From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 03 Mar 2015 04:50:23 +0900
Subject: [PATCH 0/9] ARM: samsung: randconfig build fixes
In-Reply-To: <0b2901d04b10$d571f680$8055e380$@kernel.org>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
 <0b2901d04b10$d571f680$8055e380$@kernel.org>
Message-ID: <54F4BEFF.30407@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/15 09:21, Kukjin Kim wrote:
> Arnd Bergmann wrote:
>>
>> This is a set of mostly trivial build fixes for bugs I have encountered
>> in random configurations. I'm sending them separate from the other
>> platforms since we have a lot of them for the various samsung platforms
>> here.
>>
>> Kukjin, please pick them up into a fixes branch for 3.20 or send
>> an Ack so we can apply them directly.
>>
> Sure, I will create a branch for them in this week. IMO, would be better if I
> could make a non-critical fixes branch for v3.20 in Samsung tree for further
> other Samsung stuff for v3.20 ;)
> 
>> Let me know if anything looks wrong with some of the patches.
> 
> OK, if anything I'll let you know.
> 
> Thanks for your pointing out.
> Happy new year again! (Actually it's the Lunar New Year holidays now)
> 
> - Kukjin
> 
>> Arnd Bergmann (9):
>>   ARM: s3c64xx: add I2C dependencies where needed
>>   ARM: s3c64xx: fix building without CONFIG_PM_SLEEP
>>   ARM: s3c64xx: fix __initdata section mismatch
>>   ARM: s3c24xx: use SAMSUNG_WAKEMASK for s3c2416
>>   ARM: s3c24xx: fix building without PM_SLEEP
>>   ARM: s3c24xx: fix header file inclusions
>>   ARM: s3c24xx: avoid a Kconfig warning
>>   ARM: EXYNOS: suspend requires regulator access
>>   ARM: EXYNOS: make exynos 4210 cpuidle build without SMP

Arnd,

BTW, I can't see exynos related patches in my mailbox, I don't know the
reason...can you please re-send it?

Thanks,
Kukjin
