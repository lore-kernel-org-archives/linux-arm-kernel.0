From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 15:31:27 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414142026.GD1452@sirena.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<20110414142026.GD1452@sirena.org.uk>
Message-ID: <20110414143127.GB6259@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 03:20:26PM +0100, Mark Brown wrote:
> On Thu, Apr 14, 2011 at 03:31:27PM +0300, Tony Lindgren wrote:
> 
> > I think that 6k lines of new code should wait in the platform specific
> > trees and not get merged until we have some real progress on the
> > consolidation of code.
> 
> > We should make it clear that we're not merging new code except for code
> > consolidation. Looks like some people have missed it despite the
> > massive flaming.
> 
> Personally I had formed the impression that this was an understandable
> reaction on the part of Russell that he was applying to his own trees
> rather than a general policy that was being applied over all of arch/arm.

Given that the non-platform stuff isn't the problem, such a policy has no
effect if its restricted to the core code.
