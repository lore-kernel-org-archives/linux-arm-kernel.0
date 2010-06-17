From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Thu, 17 Jun 2010 12:24:19 +0300
Subject: [PATCH] arm/include: Fix missing semicolon in module.h
In-Reply-To: <201006161932.00542.PeterHuewe@gmx.de>
References: <201006161932.00542.PeterHuewe@gmx.de>
Message-ID: <20100617092419.GI17639@pcarmody-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/10 19:32 +0200, ext Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch fixes a missing semicolon which introduced buildfailures [2] for
> almost every arm defconfig, introduced by patch cecaa4c6b [1]
> 
> This issue arises only if CONFIG_ARM_UNWIND is not set.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

My bad, sorry. 

Acked-by: Phil Carmody <ext-phil.2.carmody@nokia.com>

> ---
> KernelVersion: linux-next-20100616
> References:
> [1] cecaa4c6b ARM: 6172/1: module - additional unwind tables for exit/devexit
> [2] http://kisskb.ellerman.id.au/kisskb/compiler/11/
> [3] http://kisskb.ellerman.id.au/kisskb/buildresult/2725882/
> 
>  arch/arm/include/asm/module.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index fcff0d2..cbb0bc2 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -26,7 +26,7 @@ struct mod_arch_specific {
>  };
>  #else
>  struct mod_arch_specific {
> -}
> +};
>  #endif
>  
>  /*
> -- 
> 1.6.4.4
