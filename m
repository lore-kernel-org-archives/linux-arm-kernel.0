From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 22:34:32 +0000
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <51354E35.1080804@codeaurora.org>
References: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
 <512E9A39.3070207@wwwdotorg.org> <51354E35.1080804@codeaurora.org>
Message-ID: <201303052234.32723.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Stephen Boyd wrote:
> On 02/27/13 15:43, Stephen Warren wrote:
> >
> > Seems simple enough it doesn't really need many, but for Tegra,
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> >
> > Which kernel is this going into? It's possible Tegra will get converted
> > to multi-platform in 3.10, which might move that main ARCH_TEGRA block
> > from arch/arm/Kconfig into arch/arm/mach-tegra/Kconfig, although I
> > suppose it doesn't have to move it. I think some/all(?) other
> > multi-platform conversions have moved their main Kconfig option like
> > that though.
> 
> Thanks. I'm hoping that Arnd/Olof can pick this up. I'm not sure which
> version it will go into.
> 

Hmm, it certainly looks useful to me. I think it should go into the next
cleanup branch as a base, so others can build on top of it. We will
also need it for the Exynos multiplatform patches that I hope can land
in 3.10 as well.

Sneaking it in through the fixes branch would make life easier for us,
but it doesn't feel right.

	Arnd
