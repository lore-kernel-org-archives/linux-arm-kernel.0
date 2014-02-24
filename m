From: s-anna@ti.com (Suman Anna)
Date: Mon, 24 Feb 2014 11:06:18 -0600
Subject: [GIT PULL] ARM: OMAP2+: clock/PRCM/hwmod fixes for v3.14-rc
In-Reply-To: <20140221230300.GA5342@atomide.com>
References: <alpine.DEB.2.02.1402192120200.8777@utopia.booyaka.com>
 <53052219.9060109@ti.com>
 <alpine.DEB.2.02.1402200257060.25798@utopia.booyaka.com>
 <53061D61.6000105@ti.com> <20140221230300.GA5342@atomide.com>
Message-ID: <530B7C0A.2020002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 02/21/2014 05:03 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140220 07:24]:
>> On 02/19/2014 08:58 PM, Paul Walmsley wrote:
>>> On Wed, 19 Feb 2014, Nishanth Menon wrote:
>>>
>>>> Paul,
>>>> On 02/19/2014 03:22 PM, Paul Walmsley wrote:
>>>> [...]
>>>>>
>>>>> - ----------------------------------------------------------------
>>>>> Illia Smyrnov (1):
>>>>>        ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
>>>>>
>>>>> Suman Anna (1):
>>>>>        ARM: DRA7: hwmod data: correct the sysc data for spinlock
>>>>>
>>>>> Tomi Valkeinen (1):
>>>>>        ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
>>>>>
>>>>> Vaibhav Bedia (1):
>>>>>        ARM: OMAP5: PRM: Fix reboot handling
>>>>>
>>>>
>>>> https://patchwork.kernel.org/patch/3585321/ missing?
>>>
>>> If that fixes a bug, then that should be documented in the commit
>>> description.
>>>
>>> Otherwise it's 3.15 material.
>> Fair enough, this'd be something that might be called an optimization,
>> thanks for queueing it.
>

Can you also pull in the following fix for OMAP4 that is similar to the 
one that Paul already pulled in for DRA7

https://patchwork.kernel.org/patch/3399021/

regards
Suman
