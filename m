From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 17 Dec 2010 14:59:10 -0500 (EST)
Subject: [PATCH 28/40] ARM: sched_clock: provide common infrastructure for
	sched_clock()
In-Reply-To: <20101217194026.GE9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYmu-0006jS-Na@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1012171334530.10437@xanadu.home>
	<20101217190554.GD9937@n2100.arm.linux.org.uk>
	<20101217191857.GA24940@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012171436100.10437@xanadu.home>
	<20101217194026.GE9937@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1012171457330.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Dec 2010, Russell King - ARM Linux wrote:

> On Fri, Dec 17, 2010 at 02:37:41PM -0500, Nicolas Pitre wrote:
> > On Fri, 17 Dec 2010, Russell King - ARM Linux wrote:
> > 
> > > +	local_irq_disable();
> > 
> > Actually, wouldn't it be better to use raw_local_irq_disable() here so 
> > this is safe with a RT kernel as well?
> 
> Grr, there's too many different combinations of stuff... yes, it should be.

That's why we have peer review.  :-)


Nicolas
