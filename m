From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Sep 2009 09:35:14 +0200
Subject: 'bx lr' vs 'mov pc,lr'
In-Reply-To: <94a0d4530909131847g2295b93by47de1785cc2f34b4@mail.gmail.com>
References: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
	<20090913225835.GB30169@n2100.arm.linux.org.uk>
	<94a0d4530909131711hf068509x900f19b5dfe8141d@mail.gmail.com>
	<20090914002005.GC30621@shareable.org>
	<94a0d4530909131847g2295b93by47de1785cc2f34b4@mail.gmail.com>
Message-ID: <20090914073514.GA15883@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 04:47:35AM +0300, Felipe Contreras wrote:
> On Mon, Sep 14, 2009 at 3:20 AM, Jamie Lokier <jamie@shareable.org> wrote:
> > Felipe Contreras wrote:
> >> > Why do you want bx? ?bx isn't available on older CPUs.
> >>
> >> Isn't it faster? I don't know if it would make sense to try it on
> >> newer CPUs.
> >
> > That's interesting. ?Do you know if it's faster?
> 
> Nope, I'm assuming because of this:
> http://newsgroups.derkeiler.com/Archive/Comp/comp.sys.arm/2006-04/msg00031.html

For ARM9EJ-S the docs can be found at

	http://infocenter.arm.com/help/topic/com.arm.doc.ddi0222b/I1028171.html

.  bx takes 3 cycles, mov (with dest=pc) takes 4 cycles.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
