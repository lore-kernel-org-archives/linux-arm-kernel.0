From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 07 Feb 2011 14:42:15 +0900
Subject: [PATCH] ARM: SAMSUNG: Ensure struct sys_device is declared in
	plat/pm.h
In-Reply-To: <1296741328-29435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1296741328-29435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <000201cbc689$cd0a88f0$671f9ad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Previously we were relying on it being pulled in by other headers for
> the prototype of s3c24xx_irq_suspend() and s3c24xx_irq_resume().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/include/plat/pm.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-
> samsung/include/plat/pm.h
> index d9025e3..30518cc 100644
> --- a/arch/arm/plat-samsung/include/plat/pm.h
> +++ b/arch/arm/plat-samsung/include/plat/pm.h
> @@ -17,6 +17,8 @@
> 
>  #include <linux/irq.h>
> 
> +struct sys_device;
> +
>  #ifdef CONFIG_PM
> 
>  extern __init int s3c_pm_init(void);
> --

Ok..applied, Thanks :)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
