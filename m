From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 18:41:12 +0000
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <20160210125936.GD31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <20160210125936.GD31506@lukather>
Message-ID: <20160210184112.GC28728@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 01:59:36PM +0100, Maxime Ripard wrote:
> > Also this totally ignores any other DT user (U-Boot, FreeBSD, you
> > name it).
> 
> Which all have their own DT copies, with their own bindings, that we
> (ie Linux) never agreed on.

The FreeBSD guys are actually trying to align with the Linux DTs, which
they periodically import (at least for arm64). From everything I've seen
the U-Boot guys generally want to align with Linux, and have been
attempting to some extent to do so (e.g. submitting bindings).

So if anything, Linux DTs are being used by others who didn't have much
say on them, rather than the other way around.

Regardless, the existece of fragmentation is not a good argument for
more fragmentation.

Thanks,
Mark.
