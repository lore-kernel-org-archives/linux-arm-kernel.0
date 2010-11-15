From: jkosina@suse.cz (Jiri Kosina)
Date: Mon, 15 Nov 2010 14:27:39 +0100 (CET)
Subject: [PATCH][trivial] ARM, mm: Don't include smp_plat.h twice in
	flush.c
In-Reply-To: <alpine.LNX.2.00.1011072312490.26247@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1011072312490.26247@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1011151427160.7420@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Nov 2010, Jesper Juhl wrote:

> It's enough to include the asm/smp_plat.h once in arch/arm/mm/flush.c
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  flush.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 391ffae..7d6e92b 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -17,7 +17,6 @@
>  #include <asm/smp_plat.h>
>  #include <asm/system.h>
>  #include <asm/tlbflush.h>
> -#include <asm/smp_plat.h>

Doesn't seem to be present in linux-next as of today. I have picked that 
up. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
