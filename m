From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 18 Sep 2010 11:08:27 +0100
Subject: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <20100917164543.GI20325@esdhcp04044.research.nokia.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk>
	<20100917164543.GI20325@esdhcp04044.research.nokia.com>
Message-ID: <20100918100827.GC22248@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 07:45:43PM +0300, Phil Carmody wrote:
> On 17/09/10 17:36 +0200, ext Mark Brown wrote:

> > It might be clearer to use some term other than enabled in the code -
> > when reading I wasn't immediately sure if enabled meant that it was
> > available to be selected or if it was the active operating point.  How
>   ^^^^^^^^^
> > about 'allowed' (though I'm not 100% happy with that)?

> I think your query contains its own answer.

Yeah, I didn't pick that because all of them are available in the sense
that they could in the future be enabled but I do think it's the best
option.
