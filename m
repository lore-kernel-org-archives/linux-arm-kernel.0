From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 5 Dec 2017 11:16:20 +0100
Subject: [PATCH v8 0/6] stm32 clocksource driver rework
In-Reply-To: <1f3d581f-e001-5011-829e-bf79e2f639a7@linaro.org>
References: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
 <dcff2fd0-58ca-51bb-ea2d-dfd1c5ca0cc3@st.com>
 <1f3d581f-e001-5011-829e-bf79e2f639a7@linaro.org>
Message-ID: <7f58b43f-62a9-7b5d-c444-b09299b32817@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/05/2017 11:15 AM, Daniel Lezcano wrote:
> On 05/12/2017 11:12, Alexandre Torgue wrote:
> [ ... ]
> 
>>> Benjamin Gaignard (6):
>>>  ?? clocksource: timer_of: rename timer_of_exit to timer_of_cleanup
>>>  ?? clocksource: stm32: convert driver to timer_of
>>>  ?? clocksource: stm32: increase min delta value
>>>  ?? clocksource: stm32: only use 32 bits timers
>>>  ?? clocksource: stm32: add clocksource support
>>>  ?? arm: dts: stm32: remove useless clocksource nodes
>>>
>>>  ? arch/arm/boot/dts/stm32f429.dtsi? |? 32 -----
>>>  ? arch/arm/boot/dts/stm32f746.dtsi? |? 32 -----
>>>  ? drivers/clocksource/Kconfig?????? |?? 1 +
>>>  ? drivers/clocksource/timer-of.c??? |?? 9 +-
>>>  ? drivers/clocksource/timer-of.h??? |?? 2 +-
>>>  ? drivers/clocksource/timer-stm32.c | 242
>>> ++++++++++++++++++++------------------
>>>  ? 6 files changed, 138 insertions(+), 180 deletions(-)
>>>
>>
>> What is the status of this patch-set ? Is there a chance to have it for
>> v4.16 ?
> 
> I will take care of reviewing them this week. It is in my todo list.
> 
> 
Thanks Daniel
