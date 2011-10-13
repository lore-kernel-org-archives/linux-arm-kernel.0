From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 09:23:46 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <alpine.LFD.2.02.1110111950290.17040@xanadu.home>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
Message-ID: <20111013082345.GF21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 08:03:38PM -0400, Nicolas Pitre wrote:
> On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> 
> > I've stuck them into the arm-soc tree for now, so we get linux-next
> > coverage, but I won't send them to Linus this way because then we
> > would get the same commits twice in the history.
> 
> Could you please do the same with the following:
> 
>   git://git.linaro.org/people/nico/linux.git mach_memory_h
> 
> Russell pulled it at some point, and dropped it due to concerns about 
> repeated conflict resolutions (or so I presume).  I just did a test 
> merge between your for-next branch and the above and that looked trivial 
> enough.

_and_ the breakage of the ZBOOT_ROM stuff.

So I'm now interpreting your request to Arnd to pull it as an attempt to
bypass me.  That's not what arm-soc is supposed to be about, and that's
certainly not what Linaro is supposed to be doing.

If that's how you want to behave, I'm disgusted, and be prepared for your
work to become a lot harder in the future.
