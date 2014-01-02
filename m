From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 02 Jan 2014 16:24:53 +0100
Subject: [PATCH Resend 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag
 to mout_apll
In-Reply-To: <CAK9yfHxu0f-ZSkM76HWYOpRRXvzYR2Gu2zc3-sgzMPp+_1JvWQ@mail.gmail.com>
References: <1387442019-2445-1-git-send-email-sachin.kamat@linaro.org>
 <3616477.6ZBKa1KffA@amdc1227>
 <CAK9yfHxu0f-ZSkM76HWYOpRRXvzYR2Gu2zc3-sgzMPp+_1JvWQ@mail.gmail.com>
Message-ID: <3836526.9kWglB5ajS@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Tuesday 31 of December 2013 08:24:02 Sachin Kamat wrote:
> On 30 December 2013 23:21, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Thursday 19 of December 2013 11:37:08 Mike Turquette wrote:
> >> Quoting Sachin Kamat (2013-12-19 00:33:39)
> >> > Add CLK_SET_RATE_PARENT flag to mout_apll clock. This will let us set the
> >> > clock rate in the cpufreq driver.
> >> >
> >> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >>
> >> Ack.
> >
> > Applied onto next branch.
> 
> Thanks Tomasz. But did not find this branch in your tree [1].

I haven't pushed the branches yet, as I'm yet to collect some patches
and acks

> Also, please consider adding your tree to linux-next.

Hmm, I would consider this tree only as a staging to send pull requests
for Mike, so patches should be hitting clk-next tree quickly after getting
there. I don't think this makes a need to add this tree to linux-next.

Best regards,
Tomasz
