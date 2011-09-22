From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Sep 2011 16:10:35 -0400 (EDT)
Subject: [PATCH] ARM: Don't include mach-nuc93x/Kconfig
In-Reply-To: <1316721802-10852-1-git-send-email-swarren@nvidia.com>
References: <1316721802-10852-1-git-send-email-swarren@nvidia.com>
Message-ID: <alpine.LFD.2.00.1109221610060.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2011, Stephen Warren wrote:

> Commit 6adc1e7ff19d9befdbb7781b26fff42bb0bc21e2 "ARM: mach-nuc93x: delete"
> removed support for this sub-architecture, thus deleting that file. So,
> don't include it. grep indicates no more references to this machine.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

This is fixed in the latest arm-soc.git.




> ---
>  arch/arm/Kconfig |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 89bd520..472a7f8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -969,8 +969,6 @@ source "arch/arm/mach-netx/Kconfig"
>  source "arch/arm/mach-nomadik/Kconfig"
>  source "arch/arm/plat-nomadik/Kconfig"
>  
> -source "arch/arm/mach-nuc93x/Kconfig"
> -
>  source "arch/arm/plat-omap/Kconfig"
>  
>  source "arch/arm/mach-omap1/Kconfig"
> -- 
> 1.7.0.4
> 
