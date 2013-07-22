From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 09:47:04 +0200
Subject: [PATCH v4 04/20] clocksource: samsung_pwm_timer: Do not use
 clocksource_mmio
In-Reply-To: <51ECAD60.1000109@linaro.org>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-6-git-send-email-tomasz.figa@gmail.com>
 <51ECAD60.1000109@linaro.org>
Message-ID: <19090469.Cf6sbb33Ke@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday 22 of July 2013 05:56:16 Daniel Lezcano wrote:
> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> > In case of Samsung PWM timer, clocksource MMIO can not be used,
> > because
> > custom suspend/resume callbacks are required.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for review.

> Please in the future Cc me and Thomas Gleixner (clocksource/clockevent
> maintainers).

Oh, right, sorry. This series originally was not touching the clocksource 
driver and I just kept original recipient list.

Btw. Have you updated MAINTAINERS file? In latest linux-next I can still 
see only John Stultz and Thomas Gleixner as maintainers of 
drivers/clocksource.

Best regards,
Tomasz
