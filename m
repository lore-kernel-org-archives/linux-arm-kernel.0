From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 24 Jun 2010 15:46:51 -0400 (EDT)
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <20100624191208.GB7974@n2100.arm.linux.org.uk>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<1276840135-5982-3-git-send-email-marek.vasut@gmail.com>
	<87mxulabaw.fsf@free.fr> <201006242051.27790.marek.vasut@gmail.com>
	<20100624191208.GB7974@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1006241542380.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jun 2010, Russell King - ARM Linux wrote:

> On Thu, Jun 24, 2010 at 08:51:27PM +0200, Marek Vasut wrote:
> > Dne St 23. ?ervna 2010 19:49:59 Robert Jarzmik napsal(a):
> > > Marek Vasut <marek.vasut@gmail.com> writes:
> > > > The MCxx values must be based off memory clock, not CPU core clock.
> > > > 
> > > > This also fixes the bug where on some machines the LCD went crazy while
> > > > using PCMCIA.
> > > 
> > > That looks correct to me.
> > > 
> > > Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > 
> > > Cheers.
> > > 
> > > --
> > > Robert
> > 
> > Actually lemme rethink this ... it might still be incorrect.
> 
> As Nicolas was the one who originally wrote that code, while he was
> working for Montavista and interacting with Intel, I'd be surprised
> if he didn't try finding out what the right answer is to that fixme.

Well, I might have tried, or I might not have and this simply was never 
revisited. But I clearly don't remember any of the context anymore.

> I suspect as the fixme remained that there was no clear answer.

Whatever works in practice is probably the best answer at this point.


Nicolas
