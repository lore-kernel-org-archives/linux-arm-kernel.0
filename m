From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 3 Nov 2014 18:51:01 +0100
Subject: [PATCH v4 8/8] ARM: mediatek: Fix description for mediatek SoCs
In-Reply-To: <CABuKBeKFZQAHPR4xjCnM+nz67zE79rWPTHbc=m3VKcCX54Q8rQ@mail.gmail.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
 <1413973797-17619-9-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBe+Ew6R2Kb90-gDHBQ4HuydfFxJdYmr+v9-KNC-b0K4Tkw@mail.gmail.com>
 <1413984696.19686.72.camel@mtksdaap41>
 <CABuKBeLJuaDnCYuvvS6csNzvbTeEdgEUdZ4tBQeVPuw37JK11Q@mail.gmail.com>
 <1414129026.14830.588.camel@mtksdaap41>
 <1414719439.5833.25.camel@mtksdaap41>
 <CABuKBeKFZQAHPR4xjCnM+nz67zE79rWPTHbc=m3VKcCX54Q8rQ@mail.gmail.com>
Message-ID: <CABuKBeK_uUy=T-GX=fmMCMzCajWdg_MNt1FArTfkU49mMB65ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-31 15:53 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Hi Joe,
>
> 2014-10-31 2:37 GMT+01:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
>> Hi Matthias,
>>
>> Is this series + this new 8/8 patch OK?
>> Anything else that I should change?
>>
>
> I checked the patches on my mt8135 board and they work for me. So from
> my site everything fine.

I just had another look on them and I think they are not correct,
please see my comments in the other mail.

>
> I added the patches to my tree [0] branches v3.19-next/soc and v3.19-next/dts
> I made a small change to the commit message of patch 8 and I will try
> to send the pull request asap.
>
> Thanks,
> Matthias
>
> [0] https://github.com/mbgg/linux-mediatek
>
>> Joe.C
>>
>> On Fri, 2014-10-24 at 13:37 +0800, Yingjoe Chen wrote:
>>> From: "Joe.C" <yingjoe.chen@mediatek.com>
>>>
>>> We support more MediaTek SoCs now, update the description.
>>>
>>> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
>>> ---
>>>  arch/arm/mach-mediatek/Kconfig | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-mediatek/Kconfig
>>> b/arch/arm/mach-mediatek/Kconfig
>>> index 2c043a2..f73f588 100644
>>> --- a/arch/arm/mach-mediatek/Kconfig
>>> +++ b/arch/arm/mach-mediatek/Kconfig
>>> @@ -1,6 +1,6 @@
>>>  config ARCH_MEDIATEK
>>> -     bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
>>> +     bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
>>>       select ARM_GIC
>>>       select MTK_TIMER
>>>       help
>>> -       Support for Mediatek Cortex-A7 Quad-Core-SoC MT6589.
>>> +       Support for Mediatek MT65xx & MT81xx SoCs
>>
>>
>>
>
>
>
> --
> motzblog.wordpress.com



-- 
motzblog.wordpress.com
