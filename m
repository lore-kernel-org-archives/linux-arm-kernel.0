From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Jun 2017 08:57:13 +0100
Subject: [PATCH v4 5/6] arm64: marvell: enable ICU and GICP drivers
In-Reply-To: <20170620140722.31646-6-thomas.petazzoni@free-electrons.com>
References: <20170620140722.31646-1-thomas.petazzoni@free-electrons.com>
 <20170620140722.31646-6-thomas.petazzoni@free-electrons.com>
Message-ID: <53e3891a-d4bb-83fb-a811-599224594805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 15:07, Thomas Petazzoni wrote:
> This commit enables the newly introduced Marvell GICP and ICUs driver
> for the 64-bit Marvell EBU platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
