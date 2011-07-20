From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 02:07:26 +0900
Subject: [PATCH 0/7] ARM: SAMSUNG: Code cleanup for various devices
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <06c901cc46ff$826a9690$873fc3b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banajit Goswami wrote:
> 
>  Use generic s3c_set_platdata to perform the same job. Saves a few lines
>  of code.
> 
>  The patches are created against "for-next" branch of Kukjin Kim's tree
at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
>  These patches are only compile tested.
> 
>  o To Kukjin Kim
>   PATCH[1/7] ARM: SAMSUNG: Use generic s3c_set_platdata for TS
>   PATCH[2/7] ARM: SAMSUNG: Use generic s3c_set_platdata for FB
>   PATCH[3/7] ARM: SAMSUNG: Use generic s3c_set_platdata for HWMON
>   PATCH[4/7] ARM: SAMSUNG: Use generic s3c_set_platdata for USB OHCI
>   PATCH[5/7] ARM: SAMSUNG: Use generic s3c_set_platdata for NAND
> 
>  o To Ben Dooks
>   PATCH[6/7] ARM: S3C64XX: Use generic s3c_set_platdata for OneNAND
>   PATCH[7/7] ARM: S3C24XX: Use generic s3c_set_platdata for devices
> 
>  arch/arm/mach-s3c64xx/dev-onenand1.c |   10 +++-----
>  arch/arm/plat-s3c24xx/devs.c         |   38
++++++---------------------------
>  arch/arm/plat-samsung/dev-fb.c       |   14 +----------
>  arch/arm/plat-samsung/dev-hwmon.c    |   14 +----------
>  arch/arm/plat-samsung/dev-nand.c     |    9 ++-----
>  arch/arm/plat-samsung/dev-ts.c       |   14 +----------
>  arch/arm/plat-samsung/dev-usb.c      |    9 +------
>  7 files changed, 22 insertions(+), 86 deletions(-)
> 
> --
> 1.7.2.3

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
