From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Feb 2018 15:37:21 +0000
Subject: [RFC PATCH v2 06/12] arm64: fpsimd: include <linux/init.h> in
 fpsimd.h
In-Reply-To: <1519657500-15094-7-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-7-git-send-email-will.deacon@arm.com>
Message-ID: <20180226153720.knpw7a4fncixdb4a@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 03:04:54PM +0000, Will Deacon wrote:
> fpsimd.h uses the __init annotation, so pull in linux/init.h
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Having skimmed through, this looks like all we need.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/fpsimd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 8857a0f0d0f7..fc3527b985ca 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -22,6 +22,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/cache.h>
> +#include <linux/init.h>
>  #include <linux/stddef.h>
>  
>  /*
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
