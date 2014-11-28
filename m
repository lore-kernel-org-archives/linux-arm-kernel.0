From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:22:24 +0100
Subject: [GIT PULL 1/4] Samsung 3rd round of PM updates for v3.19
In-Reply-To: <5476CD72.2010203@kernel.org>
References: <5476CD72.2010203@kernel.org>
Message-ID: <201411281322.24699.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014, Kukjin Kim wrote:
> The following changes since commit c645a598f99768e6cc82129081458dfdd0c273b7:
> 
>   ARM: EXYNOS: Call regulator core suspend prepare and finish functions
> (2014-11-21 22:49:47 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-pm-3
> 
> for you to fetch changes up to b04fa9f704aa818b87509ff4149bba810ef8bbd8:
> 
>   ARM: EXYNOS: use u8 for val[] in struct exynos_pmu_conf (2014-11-27
> 02:47:05 +0900)
> 
> ----------------------------------------------------------------
> Samsung PM 3rd updates for v3.19
> 
> - exynos3250
>   : add PMU support
> 
> - PMU refactoring
>   : move restart code into PMU driver
>   : move restart code for exynos440 into clk driver
> 
> - use u8 for val[] in struct exynos_pmu_conf
> 
> Note that this branch is based on tags/samsung-exynos-v3.19

Pulled into next/soc, thanks!

	Arnd
