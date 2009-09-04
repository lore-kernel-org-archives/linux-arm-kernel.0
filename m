From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 4 Sep 2009 07:48:58 +0200
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903095142.GB3302@digital-scurf.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
	<20090902191026.GO25153@trinity.fluff.org>
	<20090902222641.GY32606@prithivi.gnumonks.org>
	<20090903095142.GB3302@digital-scurf.org>
Message-ID: <20090904054857.GA1542@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > does it support X kdrive 2D accelerate ?
> > > > X / kdrive is not part of the linux kernel.  Therefore, it is unrelated
> > > > to the Linux kernel code that we are working on.
> > > Unfortunately it seems that pretty much no-one uses the fb driver
> > > acceleration, I'm not even sure if it has even been exported outside
> > > the kernel, so isn't really a lot of use.
> > having cursor acceleration and things like bitblit for srolling is a real
> > pleasure if you ever happen to work for more than 5 minutes on the framebuffer
> > console, especially on a system that already has a quite high load at that time.
> > It sort-of is a standard feature, and at least in the x86/PCI/AGP world, I
> > am not awaer that any framebuffer driver would not support it.  That's why I
> > had it on my todo list.
> 
> Simtec produced a set of patches to expose the Linux Kernel FB acceleration
> primitives to userland, only to be told that it was unlikely they'd be accepted
> due to them having never been exposed before.  (Yes, it was a case of 'We have
> always done it this way, why would we want to change?')

If the performance is good enough that way (is it?), then the
interface makes sense. With all the work on kernel mode setting,
climaate probably changed; and even if not, people can be convinced
with good arguments.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
