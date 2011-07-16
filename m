From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 13:40:18 +0900
Subject: [PATCH 0/2] ARM: Samsung: I2C code cleanup
In-Reply-To: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
References: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <037101cc4372$7b875060$7295f120$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> Does the same job, while saving few lines of code.
> 
>  o To Kukjin Kim, Sangbeom Kim and Ben Dooks
> 
> Naveen Krishna Chatradhi (2):
>   ARM: Samsung: Use generic set_plat_data function
>   ARM: Samsung: Cleanup I2C code in plat-samsung
> 
>  arch/arm/plat-samsung/dev-i2c0.c         |   14 ++++++--------
>  arch/arm/plat-samsung/dev-i2c1.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c2.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c3.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c4.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c5.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c6.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/dev-i2c7.c         |   24 ++++++++----------------
>  arch/arm/plat-samsung/include/plat/iic.h |    2 ++
>  9 files changed, 64 insertions(+), 120 deletions(-)
> 
> --
> 1.7.2.3

Looks good to me, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
