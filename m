From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jan 2012 20:13:54 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120110184643.GF7164@opensource.wolfsonmicro.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <alpine.LFD.2.02.1201101341040.2722@xanadu.home>
 <20120110184643.GF7164@opensource.wolfsonmicro.com>
Message-ID: <201201102013.54958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 January 2012, Mark Brown wrote:
> 
> On Tue, Jan 10, 2012 at 01:44:54PM -0500, Nicolas Pitre wrote:
> > On Tue, 10 Jan 2012, Mark Brown wrote:
> 
> > > So, is there anything that people like me who are contributing to rather
> > > than maintaining things can do to help here beyond chasing maintainers?
> 
> > Maybe the Samsung maintainer(s) should target early merge into the 
> > arm-soc tree instead of going straight to linux-next only.  The former 
> > ends up in the later anyway.
> 
> That sounds like it'd be helpful overall but it's something that has to
> be sorted out at the maintainer level.  I'm guessing there's not really
> much that contributors can do here?

I think you did everything as good as you could, we just need to routinely
call for everyone to submit stuff in time. A number of maintainers sent stuff
after Christmas (which I expected to start the merge window) and were mostly
lucky because Linus gave us an extra 10 days to sort things out.

The most reliable way improve things is pressure from upstream. We used to
have a lot of problems with omap until Linus complained loudly and the omap
merges are working completely flawless now process-wise. In the last few
releases I pushed back on substandard at91 patches and that also turned out
really well for 3.3. This time, the samsung and pxa patches were sticking
out as being worse than the others, so that's where the pushback went and
I'm sure it will work better in the future. PXA made it in in the
end, samsung also did for the most part but not entirely and you were
unfortunate to be the contributor of the patches that missed out.

Note that we're also constantly raising the bar with our expectations here,
and we have to, in order to keep up with increasing complexity and
increasing numbers of patches getting submitted. I think overall we're
doing fine, and occasionally letting good patches get delayed by one
release is the price we have to pay, even when it hurts an individual
contributor.

	Arnd
