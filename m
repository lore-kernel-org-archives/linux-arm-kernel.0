From: liu.h.jason@gmail.com (Jason Liu)
Date: Mon, 7 Nov 2011 14:07:58 +0800
Subject: [PATCH 2/2] ARM: mxc: fix tzic build error
In-Reply-To: <1320634936-7898-2-git-send-email-richard.zhao@linaro.org>
References: <1320634936-7898-1-git-send-email-richard.zhao@linaro.org>
 <1320634936-7898-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAB4PhKeyAf+X_v_ABud25+rDud+8ujFUQeV051BXPOtuZN3pcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard,

2011/11/7 Richard Zhao <richard.zhao@linaro.org>:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> ?arch/arm/plat-mxc/tzic.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index e993a18..a3c164c 100644
> --- a/arch/arm/plat-mxc/tzic.c
> +++ b/arch/arm/plat-mxc/tzic.c
> @@ -17,6 +17,7 @@
> ?#include <linux/io.h>
>
> ?#include <asm/mach/irq.h>
> +#include <asm/exception.h>
>
> ?#include <mach/hardware.h>
> ?#include <mach/common.h>

Patch already here:
http://patchwork.ozlabs.org/patch/123421/


Jason Liu
> --
> 1.7.5.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
