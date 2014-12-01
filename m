From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 01 Dec 2014 16:56:13 +0800
Subject: [PATCH v9 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <CAD=FV=Vv3ZG3WjMSkGdAW=2Vpev2JWfqJtyFdX=PVB_YjY7__g@mail.gmail.com>
References: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>	<1416900743-29204-4-git-send-email-zyw@rock-chips.com>
 <CAD=FV=Vv3ZG3WjMSkGdAW=2Vpev2JWfqJtyFdX=PVB_YjY7__g@mail.gmail.com>
Message-ID: <547C2D2D.8050409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/01/2014 01:26 PM, Doug Anderson wrote:
> Chris,
>
> On Mon, Nov 24, 2014 at 11:32 PM, Chris Zhong <zyw@rock-chips.com> wrote:
>> add pmu sram node for suspend, add global_pwroff pinctrl.
>> The pmu sram is used to store the resume code.
>> global_pwroff is held low level at work, it would be pull to high
>> when entering suspend. reference this in the board DTS file since
>> some boards need it.
>>
>> Signed-off-by: Tony Xie <xxx@rock-chips.com>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Doug Anderson <dianders@chromium.org>
>>
>> ---
>>
>> Changes in v9: None
> This is untrue.  v8 had more stuff than v9.  See:
>
> https://patchwork.kernel.org/patch/5311621/
>
> vs.
>
> https://patchwork.kernel.org/patch/5372911/
>
> I prefer v8.
>
>
>
Ah, I missed the ddr pinctrl in V9, Thank you.
I have modified it, and post the V10.
