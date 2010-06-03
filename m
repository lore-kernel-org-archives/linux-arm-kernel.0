From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 3 Jun 2010 22:27:56 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100603200109.GC9169@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006032155.19349.marek.vasut@gmail.com>
	<20100603200109.GC9169@n2100.arm.linux.org.uk>
Message-ID: <201006032227.56429.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 3. ?ervna 2010 22:01:09 Russell King - ARM Linux napsal(a):
> On Thu, Jun 03, 2010 at 09:55:19PM +0200, Marek Vasut wrote:
> > Dne ?t 3. ?ervna 2010 21:24:59 Russell King - ARM Linux napsal(a):
> > > The subject says everything you need to know.  Randy provided this
> > > 
> > > link earlier:
> > >   http://lkml.org/lkml/2010/6/2/472
> > > 
> > > Linus doesn't appear to be listening to reason, so I see now this as
> > > a fait accompli.  It'll apparantly happen at the next merge window.
> > 
> > The defconfigs age ... there's no point keeping them. They'll be useless
> > crap unless someone updates them often anyway.
> > 
> > Maybe adding a Kconfig option that's select all the default stuff the
> > platform needs would be a way to go ? (that was already proposed there)
> 
> The problem comes (as Daniel pointed out _after_ my suggested solution to
> this problem) is if you want to turn off something that's 'selected' in
> this way.

Yup, I got the point.
> 
> Anyway, let's not start a new lengthy thread on the subject here; it won't
> have much effect being only on this list.

Just as Nicolas pointed out, we need a solution. I guess lenghty thread is 
unavoidable, sorry. If possible, could you CC interested parties ?

btw. Maybe updating the machine registry so it allows pasting/attaching a 
defconfig with information about kernel version the defconfig corresponds with ?
