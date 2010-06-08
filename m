From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Jun 2010 08:50:39 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <4C0E3B0A.4040304@xenontk.org>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<4C0E3B0A.4040304@xenontk.org>
Message-ID: <alpine.LFD.2.00.1006080849540.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Jun 2010, David John wrote:

> On 06/08/2010 05:28 PM, Russell King - ARM Linux wrote:
> > On Fri, Jun 04, 2010 at 04:51:24PM -0400, Nicolas Pitre wrote:
> >> Linus wants something to be done about the current defconfig mess which 
> >> is perfectly legitimate.  He even suggested a possible solution.  I 
> >> don't think he'll simply drop those defconfig files if we demonstrate 
> >> that we're taking action to fix the actual problem.
> > 
> > However, having a set of patches which combine a load of defconfig
> > files into one is not going to solve the problem.
> > 
> > If you're hypothesis that Linus is only looking at the diffstat, then
> > what are patches to combine the defconfigs going to do?  It's going
> > to create lots of noise in arch/arm/configs/ - which is precisely what
> > Linus is complaining about.  In fact, patch-wise it's going to create
> > an extremely large patch.  And if we do this time and time again while
> > progressively reducing the defconfigs.  No, this isn't the answer -
> > it's only going to make the problem worse.
> > 
> 
> Hi,
> 
> I don't know if this is acceptable and it's just a suggestion - Once the
> defconfig 'mess' is fixed, why not move it to Documentation/arm/configs
> or somewhere similar where it won't interfere with the arch diffstat?

This would only _move_ the problem instead of fixing it.


Nicolas
