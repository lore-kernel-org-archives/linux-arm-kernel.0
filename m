From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 13 Aug 2015 12:49:46 +0800
Subject: [PATCH 0/5] add GPT timer support for mt8173
In-Reply-To: <55CB3CCB.6020607@linaro.org>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <CAGS+omAeYhXDpBueG-F_gYBccqeaejN9k5bRKC78aDLfvHfnBA@mail.gmail.com>
 <55CB3CCB.6020607@linaro.org>
Message-ID: <CAGS+omA7+O+hKqcSjYabLL08T1Va-Ryw=dNB_ZA34++-04dHHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 8:32 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 08/11/2015 05:54 PM, Daniel Kurtz wrote:
>>
>> On Mon, Jul 13, 2015 at 5:32 PM, Yingjoe Chen <yingjoe.chen@mediatek.com>
>> wrote:
>>>
>>> This series add GPT timer support for mt8173. This is based on v4.2-rc1
>>> and Matthias' next branch (for dts parts).
>>>
>>> The first 2 patches comes from 'Add SMP bringup support for mt65xx socs'
>>> series [1]. I decide to move these 2 patches to this series, since it
>>> is more relevent here. They are changed based on Matthias' and Daniel's
>>> comments.
>>>
>>> [1]
>>> http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html
>>>
>>> Daniel Kurtz (1):
>>>    arm64: dts: mt8173: add timer node
>>>
>>> Yingjoe Chen (4):
>>>    clocksource: mediatek: do not enable GPT_CLK_EVT when setup
>>>    clocksource: mediatek: Use GPT as sched clock source
>>>    arm64: mediatek: enable MTK_TIMER
>>>    clk: mediatek: add 13mhz clock for MT8173
>>
>>
>> Was this mediatek clocksource patch set get forgotten again?
>
>
> Yep. Sounds like it felt at the wrong moment.
>
>> All 5 patches have have been reviewed, and I think the ones that need
>> it have been Ack'ed by Matthias and/or Stephen.
>> What is the plan for merging them?
>
>
> So if I am not wrong we have two patches I can take in my tree as a couple
> of fixes (1 and 2), right ?

Yes.
Patches 3 & 5 are for Matthias, and patch 4 is Ack'ed by Stephen Boyd,
so I assume Matthias can pick that one up too.

Matthias, is that correct?
Or does Patch 4 need to go in via a clock maintainer's tree?

-Dan
