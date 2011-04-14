From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Apr 2011 17:26:54 +0300
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414142026.GD1452@sirena.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<20110414142026.GD1452@sirena.org.uk>
Message-ID: <20110414142654.GD3336@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [110414 17:17]:
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
> 
> I think we need to give people a tractable route to addressing the
> consolidation issues with the code they're trying to contribute before
> we start rejecting code.  If we can identify something useful that
> people can do that's in some way related to what they're trying to
> accomplish that's constructive and likely to inspire contributions to
> the consolidation efforts but if we're rejecting the code without
> any route to improving it that's much less so.  

I don't have anything against adding new code as long as it makes sense
from consolidation point of view.

But obviously just adding thousands of lines of new platform specific
code the old way does not help the situation at all.

Regards,

Tony
