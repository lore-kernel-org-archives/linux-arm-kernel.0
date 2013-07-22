From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 22:17:23 +0200
Subject: [PATCH v4 04/20] clocksource: samsung_pwm_timer: Do not use
 clocksource_mmio
In-Reply-To: <51ED925D.3060307@linaro.org>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <19090469.Cf6sbb33Ke@flatron> <51ED925D.3060307@linaro.org>
Message-ID: <7854904.Q0hSxIdabT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 of July 2013 22:13:17 Daniel Lezcano wrote:
> On 07/22/2013 09:47 AM, Tomasz Figa wrote:
> > Hi Daniel,
> > 
> > On Monday 22 of July 2013 05:56:16 Daniel Lezcano wrote:
> >> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> >>> In case of Samsung PWM timer, clocksource MMIO can not be used,
> >>> because
> >>> custom suspend/resume callbacks are required.
> >>> 
> >>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> >>> ---
> >> 
> >> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > Thanks for review.
> > 
> >> Please in the future Cc me and Thomas Gleixner
> >> (clocksource/clockevent
> >> maintainers).
> > 
> > Oh, right, sorry. This series originally was not touching the
> > clocksource driver and I just kept original recipient list.
> > 
> > Btw. Have you updated MAINTAINERS file? In latest linux-next I can
> > still see only John Stultz and Thomas Gleixner as maintainers of
> > drivers/clocksource.
> 
> Yes, right last week :)
> 
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timer
> s/core&id=9222d247bcbaacc40fe15549158f9d67523c1ace

OK, great, just wanted to make sure. Apparently linux-next did not pick 
this up.

Best regards,
Tomasz
