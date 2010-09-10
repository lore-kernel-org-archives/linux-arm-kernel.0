From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 11 Sep 2010 08:40:33 +0900
Subject: [PATCH 2/2] ARM: Update number of VIC for S5P6442 and S5PC100
In-Reply-To: <1284120193-23291-3-git-send-email-kgene.kim@samsung.com>
References: <1284120193-23291-1-git-send-email-kgene.kim@samsung.com>
	<1284120193-23291-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <000101cb5141$922985f0$b67c91d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Update the number of IVC to handle the 3 VICs of the
> S5P6442 and S5PC100.
> 
Oh, need to fix typo :-)

Update the number of VIC to handle the 3 VICs of the
S5P6442 and S5PC100.

> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> ---
>  arch/arm/common/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index 0ac3d81..6480685 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -7,6 +7,7 @@ config ARM_VIC
>  config ARM_VIC_NR
>  	int
>  	default 4 if ARCH_S5PV210
> +	default 3 if ARCH_S5P6442 || ARCH_S5PC100
>  	default 2
>  	depends on ARM_VIC
>  	help
> --
> 1.6.2.5


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
