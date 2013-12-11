From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 11 Dec 2013 15:05:03 +0100
Subject: [GIT PULL RESEND2] clocksource/clockevents fixes for 3.13
In-Reply-To: <52A87077.1030800@linaro.org>
References: <52A767CB.3010501@linaro.org> <20131210194852.GB21814@gmail.com>
 <52A87077.1030800@linaro.org>
Message-ID: <20131211140503.GA3846@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 12/10/2013 08:48 PM, Ingo Molnar wrote:
> 
> [ ... ]
> 
> >>
> >>  drivers/clocksource/Kconfig              |    1 +
> >>  drivers/clocksource/clksrc-of.c          |    1 -
> >>  drivers/clocksource/dw_apb_timer_of.c    |    7 ++++---
> >>  drivers/clocksource/sun4i_timer.c        |    3 +++
> >>  drivers/clocksource/time-armada-370-xp.c |   10 +++++-----
> >>  5 files changed, 13 insertions(+), 9 deletions(-)
> >
> >Pulled into tip:timers/urgent, thanks a lot Daniel!
> 
> Thanks to you for helping me to be a better maintainer. All you
> comments and advices were very valuable.

You are welcome!

Thanks,

	Ingo
