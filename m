From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 14 Sep 2014 02:44:52 +0900
Subject: [PATCH] ARM: S3C24XX: remove separate restart code
In-Reply-To: <15331569.UPPHKgXBj9@diego>
References: <15331569.UPPHKgXBj9@diego>
Message-ID: <54148294.50906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/14 00:30, Heiko St?bner wrote:
> The restart-handler series from Guenter Roeck got accepted recently and
> implements among other things also the restart handler in the samsung
> watchdog driver and where applicable in the clock drivers. So there is
> no need for having the restart callbacks in s3c24xx boards anymore.
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> ---
>   arch/arm/mach-s3c24xx/Kconfig                      |  2 --
>   arch/arm/mach-s3c24xx/common.c                     |  4 ----
>   arch/arm/mach-s3c24xx/common.h                     |  5 -----
>   .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h |  2 --
>   arch/arm/mach-s3c24xx/mach-amlm5900.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-anubis.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-at2440evb.c             |  1 -
>   arch/arm/mach-s3c24xx/mach-bast.c                  |  1 -
>   arch/arm/mach-s3c24xx/mach-gta02.c                 |  1 -
>   arch/arm/mach-s3c24xx/mach-h1940.c                 |  1 -
>   arch/arm/mach-s3c24xx/mach-jive.c                  |  1 -
>   arch/arm/mach-s3c24xx/mach-mini2440.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-n30.c                   |  2 --
>   arch/arm/mach-s3c24xx/mach-nexcoder.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-osiris.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-otom.c                  |  1 -
>   arch/arm/mach-s3c24xx/mach-qt2410.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-rx1950.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-rx3715.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  1 -
>   arch/arm/mach-s3c24xx/mach-smdk2410.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-smdk2413.c              |  3 ---
>   arch/arm/mach-s3c24xx/mach-smdk2416.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-smdk2440.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-smdk2443.c              |  1 -
>   arch/arm/mach-s3c24xx/mach-tct_hammer.c            |  1 -
>   arch/arm/mach-s3c24xx/mach-vr1000.c                |  1 -
>   arch/arm/mach-s3c24xx/mach-vstms.c                 |  1 -
>   arch/arm/mach-s3c24xx/s3c2410.c                    | 13 ------------
>   arch/arm/mach-s3c24xx/s3c2412.c                    | 23 ----------------------
>   arch/arm/mach-s3c24xx/s3c2416.c                    |  8 --------
>   arch/arm/mach-s3c24xx/s3c2443.c                    |  8 --------
>   arch/arm/mach-s3c24xx/s3c244x.c                    | 12 -----------
>   33 files changed, 104 deletions(-)
>
Looks good to me, applied.

Thanks,
Kukjin
