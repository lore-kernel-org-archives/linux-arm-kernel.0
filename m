From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 14:13:08 +0100
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain
	framework for EXYNOS4210
In-Reply-To: <201110021508.44083.rjw@sisk.pl>
References: <4E4360B2.2060508@samsung.com> <201110021347.02146.rjw@sisk.pl>
	<20111002114811.GU11710@n2100.arm.linux.org.uk>
	<201110021508.44083.rjw@sisk.pl>
Message-ID: <20111002131307.GV11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 03:08:43PM +0200, Rafael J. Wysocki wrote:
> On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> > How do these misconceptions start?
> > 
> > The clock API.  Drivers are supposed to get a clock (source) when they
> > initialize.  Drivers then enable and disable the clock as they _themselves_
> > require the use of that clock.
> 
> OK
> 
> Now think of a driver that should handle the same device on both ARM and
> x86-based SoCs.  Is the clock API available on x86?

No one's bothered yet.
