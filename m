From: jkosina@suse.cz (Jiri Kosina)
Date: Sun, 10 Apr 2011 08:04:36 -0700 (PDT)
Subject: [PATCH][Trivial] ARM: Remove duplicate linux/sched.h include
	from arch/arm/plat-iop/time.c
In-Reply-To: <alpine.LNX.2.00.1103150108510.26293@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1103150108510.26293@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1104081917270.6392@deuxcents.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Mar 2011, Jesper Juhl wrote:

> There's no need to include linux/sched.h more than once 
> in arch/arm/plat-iop/time.c
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  time.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
> index 07f23bb..7cdc516 100644
> --- a/arch/arm/plat-iop/time.c
> +++ b/arch/arm/plat-iop/time.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/time.h>
>  #include <linux/init.h>
> -#include <linux/sched.h>
>  #include <linux/timex.h>
>  #include <linux/sched.h>
>  #include <linux/io.h>

Seems to be present in linux-next as of today still. Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
