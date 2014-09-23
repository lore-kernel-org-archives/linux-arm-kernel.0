From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Sep 2014 15:11:08 +0100
Subject: [PATCH] arm{,64}/xen: Remove "EXPERIMENTAL" in the description
 of the Xen options
In-Reply-To: <1410988026-19949-1-git-send-email-julien.grall@linaro.org>
References: <1410988026-19949-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1409231402320.15268@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Sep 2014, Julien Grall wrote:
> The Xen ARM API is stable since Xen 4.4 and everything has been
> upstreamed in Linux for ARM and ARM64. Therefore we can drop "EXPERIMENTAL"
> from the Xen option in the both Kconfig.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org

Added to xentip


>  arch/arm/Kconfig   | 2 +-
>  arch/arm64/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 32cbbd5..aa97108 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1758,7 +1758,7 @@ config XEN_DOM0
>  	depends on XEN
>  
>  config XEN
> -	bool "Xen guest support on ARM (EXPERIMENTAL)"
> +	bool "Xen guest support on ARM"
>  	depends on ARM && AEABI && OF
>  	depends on CPU_V7 && !CPU_V6
>  	depends on !GENERIC_ATOMIC64
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd4e81a..82bd86c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -317,7 +317,7 @@ config XEN_DOM0
>  	depends on XEN
>  
>  config XEN
> -	bool "Xen guest support on ARM64 (EXPERIMENTAL)"
> +	bool "Xen guest support on ARM64"
>  	depends on ARM64 && OF
>  	select SWIOTLB_XEN
>  	help
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://secure-web.cisco.com/10fMHoxLmpT7pslRQhVXoQ98BZM4058tWPAwjHIJFPjSWRzVkTCTZ5DW4mRyexHq4j8P3ydfhTL7AEFkQAPV_2GFn8ObgHE0PFjX8z37tMXWC2pHJcJIxV4gTr-DsOt-jvgxaFlv8DQjb8Lnuuu3eSqqEw4tVTIdc7nTFoE21Jso/http%3A%2F%2Fwww.tux.org%2Flkml%2F
> 
