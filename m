From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 Feb 2011 23:22:37 -0500 (EST)
Subject: The p2v branch
In-Reply-To: <20110213114050.GB4799@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102121556330.14920@xanadu.home>
	<20110213114050.GB4799@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102152319000.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Feb 2011, Russell King - ARM Linux wrote:

> On Sat, Feb 12, 2011 at 04:01:14PM -0500, Nicolas Pitre wrote:
> > I've rebased my 2 patches on top of your latest p2v branch.  You may 
> > pull them from:
> > 
> > 	git://git.linaro.org/people/nico/linux p2v
> > 
> > Or if you prefer I can put them in the patch system.
> 
> I'd like to wait for Catalin to respond on the phys_addr_t patch - which
> allows 64-bit phys addresses.  Obviously that's going to have an impact
> on the p2v code and I'd rather someone else had the job of working out
> what to do about the T2 code.

I rebased my revised patches on top of Will's in your p2v branch and 
pushed the result to the above repository.


Nicolas
