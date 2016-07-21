From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 21 Jul 2016 16:04:18 +0100
Subject: [PATCH] ARM: mps2: fix typo
In-Reply-To: <4283147.1vrh2ZlxD5@wuerfel>
References: <f607bbd274fe705955116ba590d31ac788f402bf.1468744529.git.baruch@tkos.co.il>
 <578CABCA.4020803@arm.com> <4283147.1vrh2ZlxD5@wuerfel>
Message-ID: <c192d67a-891a-31a3-d919-d1101e1b7db4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/07/16 13:39, Arnd Bergmann wrote:
> On Monday, July 18, 2016 11:13:30 AM CEST Vladimir Murzin wrote:
>> On 17/07/16 09:35, Baruch Siach wrote:
>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>> ---
>>>  arch/arm/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 90542db1220d..8ebe5d86b707 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -901,7 +901,7 @@ config MACH_STM32F429
>>>       default y
>>>
>>>  config ARCH_MPS2
>>> -     bool "ARM MPS2 paltform"
>>> +     bool "ARM MPS2 platform"
>>>       depends on ARM_SINGLE_ARMV7M
>>>       select ARM_AMBA
>>>       select CLKSRC_MPS2
>>>
>>
>> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>
>>
>
> Merged into next/cleanup, thanks!
>

Thanks Arnd, I was thinking on how to organize into branches along with
other of/DT refcounting fixes I had for vexpress/scpi code. You made it
easy.

-- 
Regards,
Sudeep
