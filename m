From: drasko.draskovic@gmail.com (Drasko DRASKOVIC)
Date: Fri, 30 Aug 2013 17:14:17 +0200
Subject: Cortex A9 Private Timer
Message-ID: <CAEk6gTAZ9U3HgBpNDLR4ZuKkxdSHNj7wmtU_=n=-YUOaL_OnwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I was wondering is it possible to use ARM Cortex A9 private timer to
provoke interrupt due the timeout (use it as an alarm).

I have been looking in  Cortex-A9 MPCore doc, and have seen that it is
routed to IRQ29.

In arch/arm/mach-vexpress/include/mach/irqs.h I can see IRQ_LOCALTIMER
defined, but I do not see it used anywhere. Is there some example of
this timer usage I can look at and see what have to be done to set up
this timer and associate irq, so that it is triggered each time the
timer expires.

BR,
Drasko
