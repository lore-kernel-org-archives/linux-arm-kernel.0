From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jun 2010 10:08:47 +0100
Subject: [PATCH 2/3] ARM: module - simplify unwind table handling
In-Reply-To: <20100624090502.GA1398@n2100.arm.linux.org.uk>
References: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-2-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-3-git-send-email-ext-phil.2.carmody@nokia.com>
	<20100624090502.GA1398@n2100.arm.linux.org.uk>
Message-ID: <1277370527.31432.0.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-24 at 10:05 +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 03, 2010 at 03:17:21PM +0300, Phil Carmody wrote:
> >  #ifdef CONFIG_ARM_UNWIND
> ...
> > +#else
> > +struct mod_arch_specific {
> > +}
> > +#endif
> 
> I assume no one tried building these with UNWIND disabled?  linux-next
> reports most ARM builds are broken by this.
> 
> Dropped all three patches out of my git tree until it can be fixed.

It looks like a patch for fixing the build was posted on the 16th of
June, though not sure whether it went to your patch system or not.

-- 
Catalin
