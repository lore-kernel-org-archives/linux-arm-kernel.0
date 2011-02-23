From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Feb 2011 00:41:38 +0530
Subject: [PATCH 1/5] ARM: smp: Select local timers vs
	dummytimersupportruntime
In-Reply-To: <20110223190305.GB16041@n2100.arm.linux.org.uk>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
	<20110220110341.GA15494@n2100.arm.linux.org.uk>
	<e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
	<20110223163635.GA16041@n2100.arm.linux.org.uk>
	<780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com>
	<2d63c430d007703753afa4ae98902341@mail.gmail.com>
	<20110223190305.GB16041@n2100.arm.linux.org.uk>
Message-ID: <b9ea630b656efc370b6c5da78dedd41d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, February 24, 2011 12:33 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; Kevin Hilman; linux-arm-
> kernel at lists.infradead.org; tony at atomide.com; David Brown; Daniel
> Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs
> dummytimersupportruntime
>
> On Wed, Feb 23, 2011 at 11:28:11PM +0530, Santosh Shilimkar wrote:
> > Patch 6759/1 and patch 6760/1 in patch system
>
> Was there any difference between 6760 and 6753 ?
Nope.
I just rebased them together and pushed
