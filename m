From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Nov 2010 16:38:24 +0900
Subject: [PATCH 09/10] ARM S3C2412: Fix typo in CONFIG_CPU_S3C2412_ONLY
	definition
In-Reply-To: <1290969027-10178-9-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-9-git-send-email-jekhor@gmail.com>
Message-ID: <001e01cb9061$9456e020$bd04a060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> Dependency on (CPU_S3C2416 is not selected) was defined as "!CPU_2416",
> instead of "!CPU_S3C2416". Fix it.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2412/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
> index cef6a65..fa2e5bf 100644
> --- a/arch/arm/mach-s3c2412/Kconfig
> +++ b/arch/arm/mach-s3c2412/Kconfig
> @@ -16,7 +16,7 @@ config CPU_S3C2412
>  config CPU_S3C2412_ONLY
>  	bool
>  	depends on ARCH_S3C2410 && !CPU_S3C2400 && !CPU_S3C2410 && \
> -		   !CPU_2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
> +		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
>  		   !CPU_S3C2443 && CPU_S3C2412
>  	default y if CPU_S3C2412
> 
> --

Yeah, looks ok to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
