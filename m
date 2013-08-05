From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Aug 2013 10:40:55 +0900
Subject: [PATCH] clocksource: sh_cmt: 32-bit control register support
In-Reply-To: <20130804192312.GE10876@quad.lixom.net>
References: <cover.1374207810.git.horms+renesas@verge.net.au>
 <2792cc6f22031110f6959c02d42d7b6116105a71.1374207810.git.horms+renesas@verge.net.au>
 <51ECAF43.80200@linaro.org> <20130724002655.GA532@verge.net.au>
 <20130804192312.GE10876@quad.lixom.net>
Message-ID: <20130805014055.GC28465@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 12:23:12PM -0700, Olof Johansson wrote:
> On Wed, Jul 24, 2013 at 09:26:55AM +0900, Simon Horman wrote:
> > On Mon, Jul 22, 2013 at 06:04:19AM +0200, Daniel Lezcano wrote:
> > > On 07/19/2013 06:36 AM, Simon Horman wrote:
> > > > From: Magnus Damm <damm@opensource.se>
> > > > 
> > > > Add support for CMT hardware with 32-bit control and counter
> > > > registers, as found on r8a73a4 and r8a7790. To use the CMT
> > > > with 32-bit hardware a second I/O memory resource needs to
> > > > point out the CMSTR register and it needs to be 32 bit wide.
> > > > 
> > > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > 
> > > In the future, can you Cc drivers/clocksource maintainers please ?
> > 
> > Yes of course, sorry for that oversight.
> > 
> > > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > Olof, Arnd, please let me know if you wish me to re-send the pull
> > request with Daniel's Reviewed-by added to this patch.
> 
> This patch should just go in through Daniel, there's no reason to take it
> through arm-soc at all, unless you have platform code that relies on it for
> bisectability.

I'll double-check but I am reasonably sure that there are no bisection
issues. If so I'll send it through Daniel as you suggest.
