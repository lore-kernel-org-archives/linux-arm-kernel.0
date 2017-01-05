From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 11:18:18 +0000
Subject: [PATCH v2 2/4] linux/const.h: move UL() macro to
 include/linux/const.h
In-Reply-To: <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
 <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170105111818.GB29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index bfe6328..4310bcc 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -28,12 +28,6 @@
>  #include <asm/sizes.h>
>  
>  /*
> - * Allow for constants defined here to be used from assembly code
> - * by prepending the UL suffix only with actual C code compilation.
> - */
> -#define UL(x) _AC(x, UL)
> -
> -/*
>   * Size of the PCI I/O space. This must remain a power of two so that
>   * IO_SPACE_LIMIT acts as a mask for the low bits of I/O addresses.
>   */

For the arm64 bit:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
