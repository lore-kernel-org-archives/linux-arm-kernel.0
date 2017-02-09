From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Feb 2017 16:25:41 +0100
Subject: [PATCH v2 1/5] arm64: add THUNDER2 processor family
In-Reply-To: <1486256226-43889-2-git-send-email-jnair@caviumnetworks.com>
References: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
 <1486256226-43889-2-git-send-email-jnair@caviumnetworks.com>
Message-ID: <4275983.LUpotW2BbV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, February 5, 2017 12:57:02 AM CET Jayachandran C wrote:
> Add support for ThunderX2 CN99XX arm64 server processors.
> 
> Introduce a new arm64 platform config option ARCH_THUNDER2 for these
> processors.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig.platforms | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 715ef12..129cc5a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -190,6 +190,13 @@ config ARCH_THUNDER
>  	help
>  	  This enables support for Cavium's Thunder Family of SoCs.
>  
> +config ARCH_THUNDER2
> +	bool "Cavium ThunderX2 Server Processors"
> +	select GPIOLIB
> +	help
> +	  This enables support for Cavium's ThunderX2 CN99XX family of
> +	  server processors.
> +
>  config ARCH_UNIPHIER
>  	bool "Socionext UniPhier SoC Family"
>  	select ARCH_HAS_RESET_CONTROLLER
> 

Applied this one to next/arm64, thanks!

	Arnd
