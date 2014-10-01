From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 17:43:27 +0200
Subject: [GIT PULL 2/2] Exynos PM updates for v3.18
In-Reply-To: <54227E61.5060909@samsung.com>
References: <54227E61.5060909@samsung.com>
Message-ID: <201410011743.28084.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014, Kukjin Kim wrote:
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>    Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/exynos-pm
> 
> for you to fetch changes up to c3294253713cbc96df59a7cc6a9a3fc0c4ae5ba7:
> 
>    ARM: EXYNOS: Refactor the pm code to use DT based lookup (2014-09-24 
> 16:45:14 +0900)
> 
> ----------------------------------------------------------------
> PM related updates for exynos v3.18
> 
> - Refactor the pm code to use DT based lookup instead of
>    using "soc_is_exynosxxxx"
> - While at it, move exynos5250 specific disabling of JPEG
>    USE_RETENTION to pmu.c

Pulled into next/late, thanks,

	Arnd
