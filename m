From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Feb 2017 15:37:41 -0800
Subject: [PATCH] MAINTAINERS: Add Jon Mason to BCM5301X maintainers
In-Reply-To: <CAC3K-4rXAi_1aYg37of60acAh8PsuCaDUtrh0CvkkVdwKP0Fgg@mail.gmail.com>
References: <1486596146-26766-1-git-send-email-jon.mason@broadcom.com>
 <d7b40d59-4121-97ef-9829-405df8042bd7@milecki.pl>
 <CAC3K-4obNm0LLzsirCqZF9xY-Bwv---m5MeSQuv5Q65=gsngnQ@mail.gmail.com>
 <109ba5ff20b86cca145fd4e0767e9292@milecki.pl>
 <CAC3K-4rXAi_1aYg37of60acAh8PsuCaDUtrh0CvkkVdwKP0Fgg@mail.gmail.com>
Message-ID: <ffaf7ac4-cf2f-efb8-27b3-b8efbe290b34@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 03:37 PM, Jon Mason wrote:
> On Wed, Feb 8, 2017 at 6:35 PM, Rafa? Mi?ecki <rafal@milecki.pl> wrote:
>> On 2017-02-09 00:34, Jon Mason wrote:
>>>
>>> On Wed, Feb 8, 2017 at 6:29 PM, Rafa? Mi?ecki <rafal@milecki.pl> wrote:
>>>>
>>>> On 02/09/2017 12:22 AM, Jon Mason wrote:
>>>>>
>>>>>
>>>>> Adding myself as a maintainer for Broadcom Northstar SoCs.  Also, adding
>>>>> a regex entry to discover the SVK DTs already present.
>>>>>
>>>>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>>>>
>>>>
>>>>
>>>> Acked-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>>>
>>>>
>>>>>  MAINTAINERS | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 2abda6c..03c1760 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2641,12 +2641,14 @@ F:      arch/mips/include/asm/mach-bcm47xx/*
>>>>>  BROADCOM BCM5301X ARM ARCHITECTURE
>>>>>  M:     Hauke Mehrtens <hauke@hauke-m.de>
>>>>>  M:     Rafa? Mi?ecki <zajec5@gmail.com>
>>>>> +M:     Jon Mason <jonmason@broadcom.com>
>>>>>  M:     bcm-kernel-feedback-list at broadcom.com
>>>>>  L:     linux-arm-kernel at lists.infradead.org
>>>>>  S:     Maintained
>>>>>  F:     arch/arm/mach-bcm/bcm_5301x.c
>>>>>  F:     arch/arm/boot/dts/bcm5301x*.dtsi
>>>>>  F:     arch/arm/boot/dts/bcm470*
>>>>> +N:     bcm953012
>>>
>>>
>>> There are 2 now, and a 3rd one coming soon.
>>> ./arch/arm/boot/dts/bcm953012k.dts
>>> ./arch/arm/boot/dts/bcm953012er.dts
>>>
>>> It might be overkill, but I thought it was the way everyone was going
>>> (and seems to be more elegant).  I'll defer if the simpler version is
>>> desired
>>
>>
>> Maybe
>> F: arch/arm/boot/dts/bcm953012*
>> would be sufficient and more efficient?
> 
> Works for me.
> 
> Florian, you want a v2 or did you want to massage the patch by hand?

I am very lazy, so I need a v2, thanks!
-- 
Florian
