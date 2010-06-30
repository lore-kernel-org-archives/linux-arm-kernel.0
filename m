From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 20:25:14 +0200
Subject: [PATCH 18/33] Removing dead OMAP_ARM_96MHZ
In-Reply-To: <8304abb0dbda307c488b6fe2b3cc8df3c9909eb6.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<8304abb0dbda307c488b6fe2b3cc8df3c9909eb6.1277911346.git.siccegge@cs.fau.de>
Message-ID: <201006302025.14881.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 17:59:45 Christoph Egger napsal(a):
> OMAP_ARM_96MHZ doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

I'd be for adding it to Kconfig rather than removing from here
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap1/opp_data.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/opp_data.c
> b/arch/arm/mach-omap1/opp_data.c index 75a5465..060df86 100644
> --- a/arch/arm/mach-omap1/opp_data.c
> +++ b/arch/arm/mach-omap1/opp_data.c
> @@ -45,9 +45,6 @@ struct mpu_rate omap1_rate_table[] = {
>  #if defined(CONFIG_OMAP_ARM_120MHZ)
>  	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
>  #endif
> -#if defined(CONFIG_OMAP_ARM_96MHZ)
> -	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
> -#endif
>  #if defined(CONFIG_OMAP_ARM_60MHZ)
>  	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
>  #endif
