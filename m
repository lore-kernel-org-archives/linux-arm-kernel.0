From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 1 May 2015 14:13:59 -0400 (EDT)
Subject: [PATCH 0/5] Second round of MCPM refactoring
In-Reply-To: <20150501175701.GP12732@n2100.arm.linux.org.uk>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <20150501175701.GP12732@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1505011404260.7750@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 May 2015, Russell King - ARM Linux wrote:

> On Fri, May 01, 2015 at 12:06:27PM -0400, Nicolas Pitre wrote:
> > This is the sequel to the first episode that started here:
> > 
> > 	http://article.gmane.org/gmane.linux.ports.arm.kernel/401353
> > 
> > Now that most of the first set has been merged upstream, here's the last
> > set to complete the cleanup. This mainly includes the removal of the
> > backward compatibility support plus some cosmetic changes.
> > 
> > The hisi04 backend, though, is instead converted to raw SMP operations
> > as it currently doesn't benefit from MCPM at all and doesn't fit well
> > with the new backend structure.
> 
> Looks like all good stuff.  What's the merging plan for this?

I'm not sure yet.  Except for the hisi04 patch, this is all generic 
stuff.  That could go upstream either via your tree or arm-soc I 
suppose.

Of course if new MCPM-using platforms are to be merged this cycle, 
they should be using the new interface. But that's already in mainline 
so that doesn't depend on this series.

What do you think?


Nicolas
