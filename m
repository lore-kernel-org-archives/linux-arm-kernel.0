From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 Mar 2016 16:07:41 +0000
Subject: [PATCH 1/8] ARM64: Enable Amlogic Meson GXBaby platform
In-Reply-To: <56D5B490.5080604@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-2-git-send-email-afaerber@suse.de>
 <56D5AA8E.4010305@arm.com> <56D5B490.5080604@suse.de>
Message-ID: <56D5BE4D.7090107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/03/16 15:26, Andreas F?rber wrote:
> Am 01.03.2016 um 15:43 schrieb Sudeep Holla:
>> On 29/02/16 23:44, Andreas F?rber wrote:
>>> Provide the ARCH_MESON Kconfig symbol to allow enabling existing serial
>>> and i2c drivers.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>    arch/arm64/Kconfig.platforms | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index a0a69589e46c..17d0ddaa0516 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -56,6 +56,12 @@ config ARCH_MEDIATEK
>>>        help
>>>          Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
>>>
>>> +config ARCH_MESON
>>> +    bool "Amlogic Platforms"
>>> +    select ARM_GIC
>>
>> Why do you need this ? CONFIG_ARM64 selects GIC for you.
>
> ARCH_MEDIATEK above does and should be fixed too then.

Yes I did see that when I checked before replying to you and assumed you
might have taken it as reference as it's just above this entry :)

-- 
Regards,
Sudeep
