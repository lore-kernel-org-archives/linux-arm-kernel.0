From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jul 2012 08:48:40 +0800
Subject: MX28 poweroff issue
In-Reply-To: <201207191904.31000.marex@denx.de>
References: <201207040030.36713.marex@denx.de>
 <20120705201002.GB31508@n2100.arm.linux.org.uk>
 <20470.38021.796461.625280@ipc1.ka-ro>
 <201207191904.31000.marex@denx.de>
Message-ID: <20120720004839.GC31620@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 07:04:30PM +0200, Marek Vasut wrote:
> > I could reproduce this on an i.MX53 (TX53) platform too. Maybe the
> > softlockup watchdog was not enabled on those platforms which didn't
> > show this behaviour.
> 
> So what's the result, where did this discussion lead to?
> 
I have submitted a fix into Russell's patch system.  We will know
his take soon next week when he gets back from his vacation.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/176127
