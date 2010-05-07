From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 May 2010 19:03:34 +0100
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <1273252359.3542.21.camel@c-dwalke-linux.qualcomm.com>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
	<1273252359.3542.21.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100507180334.GB7887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 07, 2010 at 10:12:39AM -0700, Daniel Walker wrote:
> On Fri, 2010-05-07 at 18:02 +0100, Will Deacon wrote:
> > Hi Russell,
> > 
> > Commit ee3c454b `arm: msm: add oprofile pmu support' in your devel
> > branch adds an IRQ to the static list in kernel/pmu.c. Patch 6064/1 in
> > the patch system replaces this old functionality with runtime registration
> > using a platform device, so this commit prevents that patch applying.
> > The OProfile patches in the system also depend on the runtime registration
> > patch, so they will become blocked too.
> 
> Oh, sorry about that. I didn't realize a change like that was pending.
> When are you planning to merge these changes?

Very very soon; the old way oprofile stuff is being supported will be
going away.
