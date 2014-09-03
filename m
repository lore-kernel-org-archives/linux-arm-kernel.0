From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 13:10:32 +0200
Subject: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <4774333.eJdjGCa2sL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 12:52:16 Ulf Hansson wrote:
> 
>  arch/arm/mach-exynos/exynos.c         |   1 -
>  arch/arm/mach-s3c64xx/common.c        |   5 -
>  arch/arm/mach-s3c64xx/common.h        |   7 -
>  arch/arm/mach-s3c64xx/mach-anw6410.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-crag6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-hmt.c      |   1 -
>  arch/arm/mach-s3c64xx/mach-mini6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-ncp.c      |   1 -
>  arch/arm/mach-s3c64xx/mach-real6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-smartq5.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-smartq7.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-smdk6400.c |   1 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |   1 -
>  arch/arm/mach-s3c64xx/pm.c            |   7 -
>  arch/arm/mach-shmobile/pm-r8a7779.c   |   1 -
>  arch/arm/mach-shmobile/pm-rmobile.c   |   1 -
>  drivers/base/power/domain.c           | 322 ++++------------------------------
>  drivers/base/power/domain_governor.c  |   7 +-
>  drivers/sh/pm_runtime.c               |  11 --
>  include/linux/pm_domain.h             |  56 +-----
>  20 files changed, 40 insertions(+), 388 deletions(-)
> 

Wow, great diffstat!

I have no idea what this series really does, but I love it ;-)

	Arnd
