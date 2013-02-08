From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Feb 2013 14:42:01 -0800
Subject: [PATCH 0/2] ARM: S3C24XX: make s3c24XX.h header content local
In-Reply-To: <201302072249.04263.heiko@sntech.de>
References: <201302072249.04263.heiko@sntech.de>
Message-ID: <1a5701ce064d$840dd2f0$8c2978d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> This series moves the contents of the plat/s3c24XX.h headers into
> common.h, as their content does not need to be global anymore, now that
> everything lives in mach-s3c24xx.
> 
> Heiko Stuebner (2):
>   ARM: S3C24XX: move plat-samsung/s3c24XX headers to local common.h
>   ARM: S3C24XX: cleanup the included soc init functions in common.h
> 
>  arch/arm/mach-s3c24xx/clock-s3c2410.c        |    1 -
>  arch/arm/mach-s3c24xx/clock-s3c2412.c        |    1 -
>  arch/arm/mach-s3c24xx/clock-s3c2416.c        |    1 -
>  arch/arm/mach-s3c24xx/clock-s3c2443.c        |    1 -
>  arch/arm/mach-s3c24xx/common.c               |    7 +--
>  arch/arm/mach-s3c24xx/common.h               |   90
> +++++++++++++++++++++++++-
>  arch/arm/mach-s3c24xx/mach-jive.c            |    2 +-
>  arch/arm/mach-s3c24xx/mach-n30.c             |    1 -
>  arch/arm/mach-s3c24xx/mach-nexcoder.c        |    2 -
>  arch/arm/mach-s3c24xx/mach-otom.c            |    1 -
>  arch/arm/mach-s3c24xx/mach-smdk2413.c        |    4 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c        |    3 +-
>  arch/arm/mach-s3c24xx/mach-smdk2440.c        |    2 -
>  arch/arm/mach-s3c24xx/mach-smdk2443.c        |    4 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c           |    4 +-
>  arch/arm/mach-s3c24xx/pm-s3c2412.c           |    1 -
>  arch/arm/mach-s3c24xx/s3c2410.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c2412.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c2416.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c2440.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c2442.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c2443.c              |    1 -
>  arch/arm/mach-s3c24xx/s3c244x.c              |    2 -
>  arch/arm/plat-samsung/include/plat/s3c2410.h |   31 ---------
>  arch/arm/plat-samsung/include/plat/s3c2412.h |   32 ---------
>  arch/arm/plat-samsung/include/plat/s3c2416.h |   37 -----------
>  arch/arm/plat-samsung/include/plat/s3c2443.h |   36 ----------
>  arch/arm/plat-samsung/include/plat/s3c244x.h |   42 ------------
>  28 files changed, 99 insertions(+), 212 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h
> 
> --

Yeah, looks good to me, applied this series.

Thanks.

- Kukjin
