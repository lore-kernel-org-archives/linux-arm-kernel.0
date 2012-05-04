From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 May 2012 18:45:58 +0100
Subject: [GIT PULL] clk for next
In-Reply-To: <20120504170533.GO4141@pengutronix.de>
References: <20120504170533.GO4141@pengutronix.de>
Message-ID: <20120504174558.GA6112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:05:33PM +0200, Sascha Hauer wrote:

> Currently we are still missing the clk patches for next in -next. It
> should be fine to have these in arm-soc since probably no non-arm
> architecture will convert to the clock framework in the next two weeks.

Actually I've a patch which I keep pushing to the x86 maintainers to
enable the clock API there (ideally we'd enable it on all architectures
that don't currently have one of their own straight off).

> So Mike, please consider sending the following pull request to Arnd:

Seconded!

I'd also like to get the wm831x driver in there, I've not been looking
at it since it doesn't seem sensible to put the effort in until we've
got stuff flowing into -next.
