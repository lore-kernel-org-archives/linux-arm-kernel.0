From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 May 2014 13:30:45 +0900
Subject: [PATCH] ARM: S3C24XX: remove SAMSUNG_CLOCK remnants after ccf
 conversion
In-Reply-To: <1615843.xdRuLnoxgD@phil>
References: <1615843.xdRuLnoxgD@phil>
Message-ID: <0e4f01cf68e3$f2a63f00$d7f2bd00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> This finally removes all remaining SAMSUNG_CLOCK conditional code
> from s3c24xx architectures.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This is of course meant to go on top of the s3c2410 ccf conversion
> 
>  arch/arm/mach-s3c24xx/Kconfig         |  5 -----
>  arch/arm/mach-s3c24xx/common.c        | 17 -----------------
>  arch/arm/mach-s3c24xx/cpufreq-utils.c |  6 ------
>  arch/arm/mach-s3c24xx/mach-anubis.c   | 27 ---------------------------
>  arch/arm/mach-s3c24xx/mach-bast.c     | 27 ---------------------------
>  arch/arm/mach-s3c24xx/mach-osiris.c   | 27 ---------------------------
>  arch/arm/mach-s3c24xx/mach-rx1950.c   | 14 --------------
>  arch/arm/mach-s3c24xx/mach-vr1000.c   | 27 ---------------------------
>  arch/arm/mach-s3c24xx/pm.c            | 12 ------------
>  9 files changed, 162 deletions(-)
> 
At last, we're supporting common clock framework for s3c24xx.

Heiko, very thanks for your effort.

Will apply with your previous s3c24xx ccf series.

- Kukjin
