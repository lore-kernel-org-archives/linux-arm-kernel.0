From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 16 Jul 2014 18:20:15 +0200
Subject: [PATCH 1/4] asm-generic: Add dma-contiguous.h
In-Reply-To: <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <xa1tfvi1b7i8.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
> This header is used by arm64 and x86 individually.
>
> Adding to asm-generic to avoid further code repetition while adding cma
> to mips.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>


> ---
>  include/asm-generic/dma-contiguous.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 include/asm-generic/dma-contiguous.h
>
> diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
> new file mode 100644
> index 0000000..292c571
> --- /dev/null
> +++ b/include/asm-generic/dma-contiguous.h
> @@ -0,0 +1,9 @@
> +#ifndef _ASM_GENERIC_DMA_CONTIGUOUS_H
> +#define _ASM_GENERIC_DMA_CONTIGUOUS_H
> +
> +#include <linux/types.h>
> +
> +static inline void
> +dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> +
> +#endif
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
