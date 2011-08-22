From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 15:16:00 +0200
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822130119.GC2287@n2100.arm.linux.org.uk>
References: <20110822081000.GA16557@pengutronix.de>
	<20110822125653.GB2287@n2100.arm.linux.org.uk>
	<20110822130119.GC2287@n2100.arm.linux.org.uk>
Message-ID: <201108221516.00540.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 03:01:19 PM Russell King - ARM Linux wrote:
> On Mon, Aug 22, 2011 at 01:56:53PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Aug 22, 2011 at 02:54:55PM +0200, Marek Vasut wrote:
> > > On Monday, August 22, 2011 02:49:30 PM Russell King - ARM Linux wrote:
> > > > On Mon, Aug 22, 2011 at 01:18:25PM +0200, Marek Vasut wrote:
> > > > > On Monday, August 22, 2011 10:33:29 AM Uwe Kleine-K?nig wrote:
> > > > > > On Mon, Aug 22, 2011 at 09:17:49AM +0100, Russell King - ARM Linux 
wrote:
> > > > > > > On Mon, Aug 22, 2011 at 10:10:00AM +0200, Uwe Kleine-K?nig wrote:
> > > > > > > > Hello Russell,
> > > > > > > > 
> > > > > > > > your commit 46dcfc8 that is in today's next among other
> > > > > > > > changes does:
> > > > > > > > 
> > > > > > > > -eukrea_cpuimx25sd      MACH_EUKREA_CPUIMX25   
> > > > > > > > EUKREA_CPUIMX25 2820 -eukrea_cpuimx35sd     
> > > > > > > > MACH_EUKREA_CPUIMX35
> > > > > > > > EUKREA_CPUIMX35 2821
> > > > > > > > 
> > > > > > > > These two are both marked as "mainlined" on
> > > > > > > > http://www.arm.linux.org.uk/developer/machines/ and both are
> > > > > > > > actually used
> > > > > > > > (arch/arm/mach-imx/mach-{eukrea_cpuimx25,cpuimx35.c})
> > > > > > > > 
> > > > > > > > Can you please add them back? Maybe it's worth to
> > > > > > > > double-check the other deletions?!
> > > > > > > 
> > > > > > > No.  They're removed because they're broken (look at them) -
> > > > > > > I've added additional checks so I don't have to waste
> > > > > > > _significant_ time fixing the entries time and time again.
> > > > > > > 
> > > > > > > The requirement is that the machine_is_xxx() must match the
> > > > > > > MACH_xxx parts.  If they don't, they will not exist in future
> > > > > > > updates.
> > > > > > 
> > > > > > Ah, I wasn't aware of that requirement.
> > > > > > 
> > > > > > Eric, these machine types are owned by you. Do you care to follow
> > > > > > up?
> > > > > 
> > > > > Hi Russell,
> > > > > 
> > > > > maybe it'd be worth at least pinging the people before you kill off
> > > > > the machine so they can come up with fix?
> > > > 
> > > > I've no idea which get killed off, sorry.
> > > 
> > > This EUKREA thing from what I understood was removed from the machine
> > > database and broke things.
> > 
> > So?  The entry was broken.  The entry was changed after submission. 
> > There was no communication with me to fix things up.  Therefore I _do_
> > _not_ _care_ about it.
> 
> For further reading, see:
> http://lists.arm.linux.org.uk/lurker/message/20110815.085325.ae6ee07d.en.ht
> ml

Russell, calm down please.

Maybe it'd be better to just email the people with broken stuff, then wait ... if 
they don't reply in a week (two weeks?) then remove their stuff. And make that a 
policy.

What do you think ?

Cheers
