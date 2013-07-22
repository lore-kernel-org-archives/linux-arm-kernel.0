From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 22 Jul 2013 10:24:59 +0530
Subject: [PATCH 1/1] of/documentation: Fix a typo in
 exynos5250-clock.txt
In-Reply-To: <20130722044254.5453.82900@quantum>
References: <1373012281-26433-1-git-send-email-sachin.kamat@linaro.org>
 <0ab501ce867e$0adadd40$209097c0$%kim@samsung.com>
 <20130722044254.5453.82900@quantum>
Message-ID: <CAK9yfHySzy620riyCBHKUVH8O7v74GrtgDrjVn4yd8KYKT0zSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2013 10:12, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Kukjin Kim (2013-07-21 18:51:54)
>> Sachin Kamat wrote:
>> >
>> > The clocks should be numbered sequentially as they are represented as
>> > enum values in the clock driver.
>> >
>> > Typo introduced by commit 17d4caccef ("clk: exynos5250: register
>> > display block gate clocks to common clock framework")
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > ---
>> >  .../devicetree/bindings/clock/exynos5250-clock.txt |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> > b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> > index 781a627..1a05761 100644
>> > --- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> > +++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> > @@ -154,7 +154,7 @@ clock which they consume.
>> >    dsim0                      341
>> >    dp                 342
>> >    mixer                      343
>> > -  hdmi                       345
>> > +  hdmi                       344
>> >
>> >  Example 1: An example of a clock controller node is listed below.
>> >
>> > --
>> > 1.7.9.5
>>
>> Looks OK to me.
>>
>> Mike, do you want me to take into the samsung tree?
>
> I've pulled this into clk-next.

Thanks Mike.
Please also consider the following patch series:

http://comments.gmane.org/gmane.linux.kernel.samsung-soc/20829
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/20582

-- 
With warm regards,
Sachin
