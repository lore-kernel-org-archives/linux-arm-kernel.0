From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 May 2014 11:17:08 -0700
Subject: [GIT PULL 2/5] Samsung clock updates for 3.16
In-Reply-To: <014501cf73c8$5eb66960$1c233c20$@samsung.com>
References: <014501cf73c8$5eb66960$1c233c20$@samsung.com>
Message-ID: <20140529181708.GA18481@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:11:03AM +0900, Kukjin Kim wrote:
> The following changes since commit 34c453ce16633539a94a2e876faeb731ac1be899:
> 
>   ARM: S3C24XX: fix merge conflict (2014-05-15 05:54:38 +0900)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-clk
> 
> for you to fetch changes up to 6520e968eef4f88c076a84a80e026049d157132e:
> 
>   clk: exynos5420: Add 5800 specific clocks (2014-05-19 22:15:08 +0900)
> 
> ----------------------------------------------------------------
> Samsung clock updates for 3.16
> 
> In this time, it is having dependency with arch/arm/ for 3.16,
> I pulled them into samsung tree from Tomasz under agreement from Mike.
> 
> - Pull for_3.16/exynos5260 from Tomasz Figa:
> 
>   "This pull request contains patches preparing Samsung Common Clock
> Framework
>   helpers to support Exynos5260 by adding support for multiple clock
> providers
>   and then adding clock driver for Exynos5260."
> 
> - Pull for_3.16/clk_fixes_non_critical from Tomasz Figa:
> 
>   "This pull requests contains a number of non-critical fixes for Samsung
> clock
>   framework and drivers, including:
>   1) a series of fixes for Exynos5420 to correct clock definitions and make
> the
>   driver closer to the documentation,
>   2) several missing clocks and clock IDs added to Exynos4, Exynos5250 and
>   Exynos5420 drivers,
>   3) fix for incorrect initialization of clock table with NULL,
>   4) compiler warning fix."
> 
> - Pull for_3.16/clk_cleanup from Tomasz Figa:
> 
>   "This pull requests contains minor clean-up related to Samsung clock
>   support, including:
>   1) move Kconfig entries of Samsung clock drivers to drivers/clk,
>   2) compile drivers/clk/samsung conditionally when COMMON_CLK_SAMSUNG is
>   selected,
>   3) remove obsolete Kconfig lines after moving s3c24xx to CCF."
> 
> - Pull for_3.16/exynos3250 from Tomasz Figa:
> 
>   "This small pull request contains a patch adding clock driver for
> Exynos3250,
>   which depends on previous pull requests in this series."
> 
> - add dt bindings for exynos3250 clock
> - add exynos5800 specific clocks in current exynos5420 clock
> 
> Note that this branch is based on s3c24xx ccf branch

Hi,

Merged into next/soc. In the future, you can probably just send up topic
branches like these directly, no need to merge them together just to send them
up.


-Olof
