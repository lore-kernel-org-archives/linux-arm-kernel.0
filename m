From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 4 Jul 2012 15:30:53 +0530
Subject: [PATCH] ARM: architected timers: Mark the clockevent with the
 C3_STOP feature
In-Reply-To: <4FF41366.4060504@arm.com>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
 <4FF41366.4060504@arm.com>
Message-ID: <CAMQu2gy6ynmCviYpW2qH-_6i614zrtO7P_8CM6O7--V-0FvvKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 3:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 04/07/12 10:54, Santosh Shilimkar wrote:
> > ARM arch timers stop in low power state and hence can not wakeup CPUs in
> > deeper idle states when used as cloc event devices. Marking these clock
> > event
> > devices with C3_STOP so that during lowpower states, the tick is managed
> > by
> > wakeup capable broadcast timer.
> >
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Hi Santosh,
>
> I already have queued an identical patch from Lorenzo.
> Thanks for reminder anyway!
>
OK. Thanks for the information Mark.
Looks like I missed that one on the list.

Regards,
Santosh
