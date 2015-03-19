From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 19 Mar 2015 10:03:35 +0100
Subject: [PATCH 01/13] ARM: at91: Add big endian configuration for
 ATSAMA5D devices
In-Reply-To: <1426693992-31163-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150319090335.GH14457@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:53 Wed 18 Mar     , Ben Dooks wrote:
> The ATSAMA5D devices are based on Cortex-A5 which should work in big
> endian configuration. Add ARCH_SUPPORTS_BIG_ENDIAN if these SoCs are
> configured so we can run the system big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> CC: Andrew Victor <linux@maxim.org.za>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Jean-Christophe Plagniol-Villard
missing e-mail
> CC: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c74a443..05212fb 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -18,6 +18,7 @@ config HAVE_AT91_H32MX
>  
>  config SOC_SAMA5
>  	bool
> +	select ARCH_SUPPORTS_BIG_ENDIAN
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

on the whole patch serie

Best Regards,
J.
