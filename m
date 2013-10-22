From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Oct 2013 10:37:42 -0700
Subject: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
In-Reply-To: <CAK5ve-KWdJFuJsvQ+JS2y7bpa9j4hGdU=ceb4nAz8BKQ1M9_XA@mail.gmail.com>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org>
 <20131022170604.GP15154@atomide.com>
 <CAK5ve-KWdJFuJsvQ+JS2y7bpa9j4hGdU=ceb4nAz8BKQ1M9_XA@mail.gmail.com>
Message-ID: <20131022173742.GQ15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bryan Wu <cooloney@gmail.com> [131022 10:23]:
> On Tue, Oct 22, 2013 at 10:06 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Sebastian Reichel <sre@debian.org> [131022 06:02]:
> >> This patch moves the handling of the chip's enable pin from the board
> >> code into the driver. It also updates all board-code files using the
> >> driver to incorporate this change.
> >>
> >> This is needed for device tree support of the enable pin.
> >
> > This seems safe to merge along with the other LED patches, the
> > changes to arch/arm/mach-omap2 should not conflict with anything.
> >
> > So for the arch/arm/mach-omap2 changes:
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I'm OK for LED parts, will this patch go through omap tree? If so,
> please add my ack.
> 
> Acked-by: Bryan Wu <cooloney@gmail.com>

It's probably best that you take it via with the LED patches.

Regards,

Tony
