From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Nov 2013 15:39:13 -0800
Subject: [PATCH] ARM: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <CAOesGMhyPaMUs3XJshqZ-KYhtWhenttq7qDpF0+4dQ9PvBYVGA@mail.gmail.com>
References: <526DBEAA.4030707@linaro.org>	<1382984701-2371-1-git-send-email-sboyd@codeaurora.org>	<878uxcq1m7.fsf@linaro.org>	<20131029060058.GD21983@codeaurora.org>	<CAOesGMhjC=NDn4YiY4tQ3ZcW_rK9_qOY03CVD1eyVFC74ucdrA@mail.gmail.com>	<CAOesGMhB2Akf_B2_J3LVdt1bDvcsTE7+8Kq=NvsXmkf3EwGsiw@mail.gmail.com>	<527D5D5C.2080409@codeaurora.org>
 <CAOesGMhyPaMUs3XJshqZ-KYhtWhenttq7qDpF0+4dQ9PvBYVGA@mail.gmail.com>
Message-ID: <527D7621.2000105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 15:35, Olof Johansson wrote:
> On Fri, Nov 8, 2013 at 1:53 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>
>> Ah yes. We don't have IPI support on UP kernels but SMP_ON_UP exposes
>> arch_irq_work_raise(). How about this? We should just skip this function
>> if we're running on UP.
> Yep.
>
> Tested-by: Olof Johansson <olof@lixom.net>
>
> Send it to Russell's tracker, plz.
>

Thanks. 7887/1.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
