From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 15:30:41 +0200
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822132719.GD2287@n2100.arm.linux.org.uk>
References: <20110822081000.GA16557@pengutronix.de>
	<201108221516.00540.marek.vasut@gmail.com>
	<20110822132719.GD2287@n2100.arm.linux.org.uk>
Message-ID: <201108221530.41443.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 03:27:19 PM Russell King - ARM Linux wrote:
> On Mon, Aug 22, 2011 at 03:16:00PM +0200, Marek Vasut wrote:
> > On Monday, August 22, 2011 03:01:19 PM Russell King - ARM Linux wrote:
> > > For further reading, see:
> > > http://lists.arm.linux.org.uk/lurker/message/20110815.085325.ae6ee07d.e
> > > n.ht ml
> > 
> > Russell, calm down please.
> > 
> > Maybe it'd be better to just email the people with broken stuff, then
> > wait ... if they don't reply in a week (two weeks?) then remove their
> > stuff. And make that a policy.
> > 
> > What do you think ?
> 
> Who do I email?  Which entries are causing problems?  That's the whole
> bloody point.

Isn't the email in your database? You can't just script that ?

> 
> There's just far too much of it.  The amount of effort required to sort
> through this file each time it needs to be updated has become *excessive*.
> The amount of effort required to go through the file and identify which
> entries are broken is *excessive*.  The amount of effort required to
> find who to email is *excessive*.

Why not write a script for that ?

> 
> I don't have a few days to do that - and I'm not going to repeat it
> every time the file needs to be updated anymore.
> 
> So either I drop the change and we go back to having gplugd broken, or
> we keep the change and have the Eureka stuff broken.  Anything else is
> far too much hastle.
> 
> Given that the gplugd folk have sorted out their problems, and its the
> Eureka stuff which doesn't conform, I'd rather that Eureka was broken
> rather than gplugd.

Well then can't you split the change in two to avoid breaking both? We don't 
want to introduce breakage, do we.
