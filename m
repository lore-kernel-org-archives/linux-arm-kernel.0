From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 13:59:33 +0900
Subject: [PATCH v2] ARM: S3C64XX: Remove gpio-bank-X header files
In-Reply-To: <1303972369-17563-1-git-send-email-jy0922.shim@samsung.com>
References: <1303972369-17563-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <00fb01cc0baa$6a728e20$3f57aa60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> The gpio-bank-X header files of S3C64XX have defines which can be
> substituted by more common API, so they can be removed. This is compile
> tested only.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/dev-spi.c                  |   20 ++----
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h |   48 --------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h |   60 -----------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h |   53 ---------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h |   49 --------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h |   44 -------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h |   71
--------------------
> -
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h |   42 ------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h |   74
--------------------
> --
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h |   40 ------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h |   36 -----------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h |   54 ----------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h |   70
--------------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h |   69
--------------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h |   46 -------------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c            |    1 -
>  arch/arm/mach-s3c64xx/pm.c                       |   34 ++++++-----
>  arch/arm/mach-s3c64xx/setup-i2c0.c               |    7 +--
>  arch/arm/mach-s3c64xx/setup-i2c1.c               |    7 +--
>  arch/arm/mach-s3c64xx/sleep.S                    |    8 ++-
>  20 files changed, 37 insertions(+), 796 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
> 

Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
