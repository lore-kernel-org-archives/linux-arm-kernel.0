From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2011 16:55:12 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110419145009.GH9462@sirena.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191616.01647.arnd@arndb.de>
	<20110419145009.GH9462@sirena.org.uk>
Message-ID: <201104191655.13133.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2011, Mark Brown wrote:
> On Tue, Apr 19, 2011 at 04:16:01PM +0200, Arnd Bergmann wrote:
> 
> > That sounds like a good idea. Same for the regulator drivers that are
> > currently in arch/arm instead of drivers/regulator.
> 
> We don't have any regulator drivers in arch/arm I think (unless the ST
> one got merged, but that's actually a dual regulator/system management
> driver rather than a proper regulator - when I reviewed it I didn't flag
> the location due to the second interface on the side).

I was thinking of arch/arm/mach-ux500/regulator-db8500.c in linux-next.

I can only see regulator contents in there, what do you mean by
system management?

	Arnd
