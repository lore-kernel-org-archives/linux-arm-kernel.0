From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 3 Jan 2014 08:55:28 +0530
Subject: [PATCH Resend 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag
 to mout_apll
In-Reply-To: <3836526.9kWglB5ajS@amdc1227>
References: <1387442019-2445-1-git-send-email-sachin.kamat@linaro.org>
 <3616477.6ZBKa1KffA@amdc1227>
 <CAK9yfHxu0f-ZSkM76HWYOpRRXvzYR2Gu2zc3-sgzMPp+_1JvWQ@mail.gmail.com>
 <3836526.9kWglB5ajS@amdc1227>
Message-ID: <CAK9yfHzaMyrvvhxfV9KH-gEdcaQNAHPJ3KnUx9wcUi5BqUYpAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 2 January 2014 20:54, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Sachin,
>
> On Tuesday 31 of December 2013 08:24:02 Sachin Kamat wrote:
>> On 30 December 2013 23:21, Tomasz Figa <t.figa@samsung.com> wrote:
>> > On Thursday 19 of December 2013 11:37:08 Mike Turquette wrote:
>> >> Quoting Sachin Kamat (2013-12-19 00:33:39)
>> >> > Add CLK_SET_RATE_PARENT flag to mout_apll clock. This will let us set the
>> >> > clock rate in the cpufreq driver.
>> >> >
>> >> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >>
>> >> Ack.
>> >
>> > Applied onto next branch.
>>
>> Thanks Tomasz. But did not find this branch in your tree [1].
>
> I haven't pushed the branches yet, as I'm yet to collect some patches
> and acks
>
>> Also, please consider adding your tree to linux-next.
>
> Hmm, I would consider this tree only as a staging to send pull requests
> for Mike, so patches should be hitting clk-next tree quickly after getting
> there. I don't think this makes a need to add this tree to linux-next.

Yes, if the window period between the patches landing into your tree
and Mike's tree
is relatively small, then there is no need. Else it would be good to
avoid merge conflicts
and ease further development and testing.


-- 
With warm regards,
Sachin
