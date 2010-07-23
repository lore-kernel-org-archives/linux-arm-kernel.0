From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 14:02:43 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007231235.40625.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722135431.GS31293@n2100.arm.linux.org.uk>
	<201007231235.40625.david.jander@protonic.nl>
Message-ID: <20100723130243.GB750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 12:35:40PM +0200, David Jander wrote:
> On Thursday 22 July 2010 03:54:31 pm Russell King - ARM Linux wrote:
> > > There are important hardware-design decisions after each of those
> > > settings! If we continue this amateuristic approach, ARM-linux
> > > platforms will never get taken seriously in more demanding
> > > environments. This really needs to change.
> > 
> > "we continue this amateuristic approach" - you think we really have some
> > choice in this?  We have very little influence on this point.
> 
> You do. I work for a hardware manufacturer and we are listening!

Well, do _something_ about it then rather than endlessly discussing it.
Make sure that your boot loader is correct for all your platforms, and
then we can rely on it to be right for your platforms and omit the
setup on them.

But you won't be able to influence all hardware manufacturers.

> Also, Canonical might have some important weight here (Linaro).... and they 
> may just as well listen also.

I doubt Linaro can change the way hardware manufacturers behave either.

ARM Ltd have been going around trying to teach silicon vendors about
feeding their changes back to the kernel, and it's taken them about a
decade for this stuff to happen.

How long do you think it'll take for board-level manufacturers to get
the big picture?  I wouldn't be surprised if it takes at least another
decade.

As you seem to have a problem with the current setup, then please pick
up the campaign banner and start trying to teach the hardware vendors
about the Right Way(tm) to do things - which means addressing your
concerns _to_ the people who create them, not the people who end up
having to live with the resulting mess.
