From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Mar 2017 13:59:09 +0100
Subject: [PATCH] arm64: remove redundant header file in current.h
In-Reply-To: <1490877709-221439-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1490877709-221439-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20170330125908.GF16211@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 08:41:49PM +0800, Shaokun Zhang wrote:
> Commint 9d84fb27fa1 ("arm64: restore get_current() optimisation") has 
> removed read_sysreg() and asm/sysreg.h is redundant.
> 
> This patch removes asm/sysreg.h header file.
> 
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks for cleaning this up. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/current.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
> index 86c4041..f6580d4 100644
> --- a/arch/arm64/include/asm/current.h
> +++ b/arch/arm64/include/asm/current.h
> @@ -3,8 +3,6 @@
>  
>  #include <linux/compiler.h>
>  
> -#include <asm/sysreg.h>
> -
>  #ifndef __ASSEMBLY__
>  
>  struct task_struct;
> -- 
> 1.9.1
> 
