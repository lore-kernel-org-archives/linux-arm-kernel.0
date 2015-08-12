From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 12 Aug 2015 14:32:11 +0200
Subject: [PATCH 0/5] add GPT timer support for mt8173
In-Reply-To: <CAGS+omAeYhXDpBueG-F_gYBccqeaejN9k5bRKC78aDLfvHfnBA@mail.gmail.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <CAGS+omAeYhXDpBueG-F_gYBccqeaejN9k5bRKC78aDLfvHfnBA@mail.gmail.com>
Message-ID: <55CB3CCB.6020607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 05:54 PM, Daniel Kurtz wrote:
> On Mon, Jul 13, 2015 at 5:32 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>> This series add GPT timer support for mt8173. This is based on v4.2-rc1
>> and Matthias' next branch (for dts parts).
>>
>> The first 2 patches comes from 'Add SMP bringup support for mt65xx socs'
>> series [1]. I decide to move these 2 patches to this series, since it
>> is more relevent here. They are changed based on Matthias' and Daniel's
>> comments.
>>
>> [1] http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html
>>
>> Daniel Kurtz (1):
>>    arm64: dts: mt8173: add timer node
>>
>> Yingjoe Chen (4):
>>    clocksource: mediatek: do not enable GPT_CLK_EVT when setup
>>    clocksource: mediatek: Use GPT as sched clock source
>>    arm64: mediatek: enable MTK_TIMER
>>    clk: mediatek: add 13mhz clock for MT8173
>
> Was this mediatek clocksource patch set get forgotten again?

Yep. Sounds like it felt at the wrong moment.

> All 5 patches have have been reviewed, and I think the ones that need
> it have been Ack'ed by Matthias and/or Stephen.
> What is the plan for merging them?

So if I am not wrong we have two patches I can take in my tree as a 
couple of fixes (1 and 2), right ?




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
