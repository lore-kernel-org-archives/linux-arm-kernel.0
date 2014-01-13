From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Jan 2014 15:50:04 +0000
Subject: [PATCH v10 1/4] arm64: topology: Implement basic CPU topology
 support
In-Reply-To: <20140110182705.GR29039@sirena.org.uk>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-2-git-send-email-broonie@kernel.org>
 <20140110174558.GI925@arm.com>
 <20140110182705.GR29039@sirena.org.uk>
Message-ID: <20140113155004.GF11805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 06:27:05PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 05:45:59PM +0000, Catalin Marinas wrote:
> > The patches seem fine otherwise, apart from the last one which I
> > won't merge until we get some real numbers.
> 
> As I previously said I am really concerned about diverging from what
> arm32 has done here

There is no diverging, these are new processors with possibly different
values for these parameters.

> and the numbers don't seem any less real than the
> ones we're using there (they were generated in an identical fashion).

Were the numbers in this patch generated in any way or simply copied
from arch/arm?

> Given the hardware availability for arm64 in general is limited and
> likely to be even more so for big.LITTLE systems it seems like asking
> for problems down the line to do something different.

I'm not saying we do something different, only that we can add the
numbers once we get hold of some real hardware.

> Honestly I'm not sure there will ever be more real numbers that aren't
> benchmarked at runtime.

This could be a later addition.

-- 
Catalin
