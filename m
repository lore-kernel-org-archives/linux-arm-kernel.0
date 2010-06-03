From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jun 2010 21:01:09 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006032155.19349.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006032155.19349.marek.vasut@gmail.com>
Message-ID: <20100603200109.GC9169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 09:55:19PM +0200, Marek Vasut wrote:
> Dne ?t 3. ?ervna 2010 21:24:59 Russell King - ARM Linux napsal(a):
> > The subject says everything you need to know.  Randy provided this
> > link earlier:
> > 
> >   http://lkml.org/lkml/2010/6/2/472
> > 
> > Linus doesn't appear to be listening to reason, so I see now this as
> > a fait accompli.  It'll apparantly happen at the next merge window.
> 
> The defconfigs age ... there's no point keeping them. They'll be useless crap 
> unless someone updates them often anyway.
> 
> Maybe adding a Kconfig option that's select all the default stuff the platform 
> needs would be a way to go ? (that was already proposed there)

The problem comes (as Daniel pointed out _after_ my suggested solution to
this problem) is if you want to turn off something that's 'selected' in
this way.

Anyway, let's not start a new lengthy thread on the subject here; it won't
have much effect being only on this list.
