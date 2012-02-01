From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Feb 2012 11:03:56 +0100
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <20120130104428.GA16841@atrey.karlin.mff.cuni.cz>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <20120125213206.GJ1068@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1201251727510.2759@xanadu.home>
 <201201252358.17825.marek.vasut@gmail.com>
 <20120130104428.GA16841@atrey.karlin.mff.cuni.cz>
Message-ID: <20120201100356.GA31865@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2012-01-30 11:44:28, Cyril Hrubis wrote:
> Hi!
> > > > As a side-note, you may be pleased to know that I have SA11x0 stuff
> > > > converted to (and tested) with sparse IRQ.  That's with SA1111, the
> > > > UCB1x00 and Neponset expansion board for the Assabet all dynamically
> > > > allocating their IRQs.  The only fixed-numbered IRQs in SA11x0 in my
> > > > tree at the time of writing are the on-SoC IRQs, and the LoCoMo IRQs
> > > > (which I don't have the hardware to test for, so I'm not touching.)
> > > 
> > > That's really cool.
> > > 
> > > Not that there are many people who might still benefit from running that
> > > code, but like I said this should serve as a real and relatively simple
> > > example that might benefit more complex platforms.
> > > 
> > > 
> > > Nicolas
> > 
> > Indeed, that's good going. I'm CCing a guy who might have a SA11xx board with 
> > LoCoMo chip (that's old zaurus sl55xx, right?).
> 
> I think I still do have old zaurus in some box somewhere (I stopped playing
> with it once I got the newer one). And I think that Pavel Machek (CC) has one
> too (I think that he wanted to give away to anybody who is wishing to maintain
> the particular kernel parts and I think that in the end nobody took it).

Yep, I still have old collie (sl5500) machine. I don't really use
it...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
