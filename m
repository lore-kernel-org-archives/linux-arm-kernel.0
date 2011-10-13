From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Oct 2011 14:46:44 -0400 (EDT)
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111013082345.GF21648@n2100.arm.linux.org.uk>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<20111013082345.GF21648@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1110131437040.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:

> On Tue, Oct 11, 2011 at 08:03:38PM -0400, Nicolas Pitre wrote:
> > On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> > 
> > > I've stuck them into the arm-soc tree for now, so we get linux-next
> > > coverage, but I won't send them to Linus this way because then we
> > > would get the same commits twice in the history.
> > 
> > Could you please do the same with the following:
> > 
> >   git://git.linaro.org/people/nico/linux.git mach_memory_h
> > 
> > Russell pulled it at some point, and dropped it due to concerns about 
> > repeated conflict resolutions (or so I presume).  I just did a test 
> > merge between your for-next branch and the above and that looked trivial 
> > enough.
> 
> _and_ the breakage of the ZBOOT_ROM stuff.

In order to resolve this impass, I simply dropped the ep93xx patch from 
the series.  This could be revisited later, just like for the 
StrongARM/XScale cache mapping patches.  Pretty please, tell me if there 
is still something which is not to your satisfaction.

> So I'm now interpreting your request to Arnd to pull it as an attempt to
> bypass me.  That's not what arm-soc is supposed to be about, and that's
> certainly not what Linaro is supposed to be doing.

Not at all.  I asked Arnd to pull it not so this could go to Linus via 
the arm-soc tree, but rather that this could get increased exposure in 
both the arm-soc tree and linux-next, and get a feel for the magnitude 
of the merge conflicts and possible build errors.

I'm therefore officially asking you again to pull this series, given 
that I've removed from it the last offending piece I know about.


Nicolas
