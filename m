From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 12 Jan 2010 06:48:39 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <20100111104621.GC3440@sirena.org.uk>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262913477.2173.696.camel@pasglop>
	<201001081238.31842.jeremy.kerr@canonical.com>
	<201001111638.12204.jeremy.kerr@canonical.com>
	<20100111104621.GC3440@sirena.org.uk>
Message-ID: <1263239319.724.135.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 10:46 +0000, Mark Brown wrote:
> On Mon, Jan 11, 2010 at 04:38:12PM +1100, Jeremy Kerr wrote:
> 
> > Alternative is to move the COMMON_STRUCT_CLK API to general kernel land, and 
> > put the definitions in the global clk.h.
> 
> Wouldn't that be sensible anyway?  There's nothing ARM specific about
> any of this except that you've used it in some ARM platforms.

I wouldn't mind that in order to get the inlines on powerpc as well.

Cheers,
Ben.
