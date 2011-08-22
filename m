From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 22 Aug 2011 13:55:36 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <1313526898-19920-3-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110822055534.GA15301@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds basic support for the Calxeda Highbank platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
[...]
> diff --git a/arch/arm/mach-highbank/include/mach/entry-macro.S b/arch/arm/mach-highbank/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..56be409
> --- /dev/null
> +++ b/arch/arm/mach-highbank/include/mach/entry-macro.S
> @@ -0,0 +1,9 @@
> +#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>

It seems that the second file already includes the first one.

> +
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro	arch_ret_to_user, tmp1, tmp2
> +	.endm
> +

-- 
Regards,
Shawn
