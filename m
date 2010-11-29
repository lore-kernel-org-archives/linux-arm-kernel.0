From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Nov 2010 20:08:38 +0900
Subject: [PATCH 05/10] ARM S3C2443: Select properly ARM core type
In-Reply-To: <1290969027-10178-5-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-5-git-send-email-jekhor@gmail.com>
Message-ID: <001001cb8fb5$c8058a90$58109fb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> 
Your e-mail changed?

> Select ARM920T core when compiling kernel for s3c2443.
> 
> Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> ---
>  arch/arm/mach-s3c2443/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
> index 0b7f0d6..8814031 100644
> --- a/arch/arm/mach-s3c2443/Kconfig
> +++ b/arch/arm/mach-s3c2443/Kconfig
> @@ -5,6 +5,7 @@
>  config CPU_S3C2443
>  	bool
>  	depends on ARCH_S3C2410
> +	select CPU_ARM920T
>  	select S3C2443_DMA if S3C2410_DMA
>  	select CPU_LLSERIAL_S3C2440
>  	select SAMSUNG_CLKSRC
> --

This is ok to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
