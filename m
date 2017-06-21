From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Jun 2017 17:50:47 +0200
Subject: [PATCH v5 5/6] arm64: marvell: enable ICU and GICP drivers
In-Reply-To: <20170621132917.14187-6-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 21 Jun 2017 15:29:16 +0200")
References: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
 <20170621132917.14187-6-thomas.petazzoni@free-electrons.com>
Message-ID: <87injp1grs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., juin 21 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit enables the newly introduced Marvell GICP and ICUs driver
> for the 64-bit Marvell EBU platforms.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Applied on mvebu/arm64

Thanks,

Gregory


> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4afcffc..bf3b505 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -106,6 +106,8 @@ config ARCH_MVEBU
>  	select ARMADA_AP806_SYSCON
>  	select ARMADA_CP110_SYSCON
>  	select ARMADA_37XX_CLK
> +	select MVEBU_GICP
> +	select MVEBU_ICU
>  	select MVEBU_ODMI
>  	select MVEBU_PIC
>  	help
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
