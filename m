From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 26 Jul 2015 14:40:23 +0900
Subject: [PATCH v2] clk: exynos4: Fix wrong clock for Exynos4x12 ADC
In-Reply-To: <55AED88D.2060009@samsung.com>
References: <1434074005-18846-1-git-send-email-k.kozlowski@samsung.com>
 <20150721224235.GA30021@codeaurora.org> <55AED88D.2060009@samsung.com>
Message-ID: <55B472C7.5000109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 08:41 AM, Krzysztof Kozlowski wrote:
> On 22.07.2015 07:42, Stephen Boyd wrote:
>> >On 06/12, Krzysztof Kozlowski wrote:
[...]
>>> >>Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
>>> >>Cc:<stable@vger.kernel.org>
>>> >>Fixes: c63c57433003 ("ARM: dts: Add ADC's dt data to read raw data for exynos4x12")
>>> >>Link:https://lkml.org/lkml/2015/6/11/85
>> >
>> >Did you want clk maintainers to apply this? The To: list is not
>> >helping so I'm not sure what's going on and it seems to have
>> >slipped through the cracks.
 >
> Thank you for being proactive! I appreciate this.
> Some time ago Sylwester replied that he took care about this patch so I
> think this will go through Samsung clock tree.
>
> Sylwester, are you planning to send this as fix for 4.2-rc?

I think it qualifies for 4.3, it's not a new regression and will be
backported to -stable anyway.
I would prefer clk maintainers have applied this, otherwise I would
need to make a (questionable) pull request with only one patch, since
all patches except this one after the last merge window were part
of bigger series touching multiple subsystems and applied through
the samsung soc tree.

Thanks,
Sylwester
