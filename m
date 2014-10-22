From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 22 Oct 2014 15:53:23 +0200
Subject: [PATCH v4 8/8] ARM: mediatek: Add config option for mediatek SoCs.
In-Reply-To: <1413984696.19686.72.camel@mtksdaap41>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
 <1413973797-17619-9-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBe+Ew6R2Kb90-gDHBQ4HuydfFxJdYmr+v9-KNC-b0K4Tkw@mail.gmail.com>
 <1413984696.19686.72.camel@mtksdaap41>
Message-ID: <CABuKBeLJuaDnCYuvvS6csNzvbTeEdgEUdZ4tBQeVPuw37JK11Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

2014-10-22 15:31 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
>
> Hi Matthias,
>
> On Wed, 2014-10-22 at 15:18 +0200, Matthias Brugger wrote:
>> 2014-10-22 12:29 GMT+02:00 Joe.C <yingjoe.chen@mediatek.com>:
>> > +
>> > +if ARCH_MEDIATEK
>> > +
>> > +config MACH_MT6589
>> > +       bool "MediaTek MT6589 SoCs support"
>> > +       default ARCH_MEDIATEK
>> > +
>> > +config MACH_MT8127
>> > +       bool "MediaTek MT8127 SoCs support"
>> > +       default ARCH_MEDIATEK
>> > +
>> > +config MACH_MT8135
>> > +       bool "MediaTek MT8135 SoCs support"
>> > +       default ARCH_MEDIATEK
>> > +
>> > +endif
>>
>> MACH_MTxxxx are not used nowhere, please remove them.
>
> Yes, they are not used in this series yet.
>
> MACH_MT8135 was used in mt8135 pinctrl driver [1] and will be used in
> mt8135 clk driver we are about to send. I don't want to create false
> dependency between these 2 series so I put it here.
> Do you prefer add them when they are first used?

Yes please add them, when they are first used.
Today I had a look on the pinctrl patches you mentioned. It looks to
me as if the config is not needed in the series.

Thanks,
Matthias

[0] http://thread.gmane.org/gmane.linux.ports.arm.kernel/358505

>
> Joe.C
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/289288.html
>
>



-- 
motzblog.wordpress.com
