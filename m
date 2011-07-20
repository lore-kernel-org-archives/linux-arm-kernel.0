From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Jul 2011 22:35:12 +0900
Subject: [PATCH 0/8] ARM: SAMSUNG: Add common PWM Backlight support
In-Reply-To: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
Message-ID: <06a901cc46e2$026e7b90$074b72b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banajit Goswami wrote:
> 
>  The patches are created against "for-next" branch of Kukjin Kim's tree
at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
>  Patch [1/8]
>   -- add a common infrastructure to support PWM backlight for various
>      Samsung boards.
> 
>  Patch [2/8]
>   -- Add support for PWM backlight for SMDKV310 board.
> 
>  Patch [3/8]
>   -- Add support for PWM backlight for SMDKC210 board.
> 
>  Patch [4/8]
>   -- Add support for PWM backlight for SMDKV210 board.
> 
>  Patch [5/8]
>   -- Add support for PWM backlight for SMDKC100 board.
> 
>  Patch [6/8]
>   -- Add support for PWM backlight for SMDK6440 board.
> 
> Patch [7/8]
>   -- Add support for PWM backlight for SMDK6450 board.
> 
>  Patch [8/8]
>   -- Add support for PWM backlight for SMDK6410 board.
> 
>  Patch 3 with PWM Backlight support for SMDKC210 is only compile tested.
> 
>    [Patch 1/8] ARM: SAMSUNG: Create a common infrastructure for PWM
> backlight support
>    [Patch 2/8] ARM: EXYNOS4: Add PWM backlight support on Samsung
> SMDKV310 board
>    [Patch 3/8] ARM: EXYNOS4: Add PWM backlight support on Samsung
> SMDKC210 board
>    [Patch 4/8] ARM: S5PV210: Add PWM backlight support on Samsung
> SMDKV210 board
>    [Patch 5/8] ARM: S5PC100: Add PWM backlight support on Samsung
> SMDKC100 board
>    [Patch 6/8] ARM: S5P64X0: Add PWM backlight support on Samsung
> SMDK6440 board
>    [Patch 7/8] ARM: S5P64X0: Add PWM backlight support on Samsung
> SMDK6450 board
>    [Patch 8/8] ARM: S3C64XX: Add PWM backlight support on Samsung
> SMDK6410 board
> 
>  arch/arm/mach-exynos4/Kconfig                  |    4 +
>  arch/arm/mach-exynos4/mach-smdkc210.c          |   16 +++
>  arch/arm/mach-exynos4/mach-smdkv310.c          |   16 +++
>  arch/arm/mach-s3c64xx/Kconfig                  |    1 +
>  arch/arm/mach-s3c64xx/mach-smdk6410.c          |   15 ++-
>  arch/arm/mach-s5p64x0/Kconfig                  |    2 +
>  arch/arm/mach-s5p64x0/mach-smdk6440.c          |   54 ++-------
>  arch/arm/mach-s5p64x0/mach-smdk6450.c          |   54 ++-------
>  arch/arm/mach-s5pc100/Kconfig                  |    1 +
>  arch/arm/mach-s5pc100/mach-smdkc100.c          |   55 ++-------
>  arch/arm/mach-s5pv210/Kconfig                  |    1 +
>  arch/arm/mach-s5pv210/mach-smdkv210.c          |   54 ++-------
>  arch/arm/plat-samsung/Kconfig                  |    6 +
>  arch/arm/plat-samsung/Makefile                 |    1 +
>  arch/arm/plat-samsung/dev-backlight.c          |  151
> ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/backlight.h |   26 ++++
>  16 files changed, 291 insertions(+), 166 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-backlight.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/backlight.h
> 
> --
> 1.7.2.3

Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
