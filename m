From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 11:04:53 +0000
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <201202130547.48530.arnd@arndb.de>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <201202112007.08672.arnd@arndb.de> <20120211201430.GB24564@sirena.org.uk>
 <201202130547.48530.arnd@arndb.de>
Message-ID: <20120213110453.GA13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 05:47:48AM +0000, Arnd Bergmann wrote:
> On Saturday 11 February 2012, Mark Brown wrote:
> > On Sat, Feb 11, 2012 at 08:07:08PM +0000, Arnd Bergmann wrote:
> > > what the risk is in changing exynos4 at the same time. It would
> > > be great if we can have all exynos use the common struct clk in 3.4,
> > > but I'm also happy if we just get exynos5 to do it that way from the
> > > beginning and move exynos4 over in 3.5 after you have had a chance
> > > to make sure everything still works.
> > 
> > Are we likely to get the common struct clk in 3.4?  It's all been
> > extremely quiet on that front except for complaints about the lack of
> > progress.
> 
> Yes, we discussed it during the subarch maintainers meeting at Linaro
> Connect last week and it looks like we're finally going forward on
> this now. Maybe Grant or Mike are better at explaining the current
> status regarding the clk implementation and bindings.

That would be good for those who weren't there to be updated with what
was discussed.
