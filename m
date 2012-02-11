From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 11 Feb 2012 20:14:30 +0000
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <201202112007.08672.arnd@arndb.de>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
 <201202112007.08672.arnd@arndb.de>
Message-ID: <20120211201430.GB24564@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 08:07:08PM +0000, Arnd Bergmann wrote:

> what the risk is in changing exynos4 at the same time. It would
> be great if we can have all exynos use the common struct clk in 3.4,
> but I'm also happy if we just get exynos5 to do it that way from the
> beginning and move exynos4 over in 3.5 after you have had a chance
> to make sure everything still works.

Are we likely to get the common struct clk in 3.4?  It's all been
extremely quiet on that front except for complaints about the lack of
progress.
