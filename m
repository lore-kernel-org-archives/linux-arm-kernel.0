From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Apr 2014 23:00:50 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <20140416205001.GY12304@sirena.org.uk>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <5094962.iM2Kd6gfjd@wuerfel> <20140416205001.GY12304@sirena.org.uk>
Message-ID: <4235968.l5YN2u3Kvp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 April 2014 21:50:01 Mark Brown wrote:
> On Wed, Apr 16, 2014 at 08:14:27PM +0200, Arnd Bergmann wrote:
> 
> > This patch does a partial revert of 313367e7bfa by allowing these
> > drivers on all samsung platforms except EXYNOS, so we can proceed
> > with the multiplatform patches.
> 
> > If support for these drivers is actually needed on EXYNOS machines,
> > the drivers should first be moved over to use the dmaengine code.
> 
> I would be surprised if neither IP is present on any Exynos SoC, they
> were added in the s5p range.  Is Sachin's fix for building these
> (present in -rc1) not doing the job?

I hadn't noticed that patch, it probably does, so nevermind.

	Arnd
