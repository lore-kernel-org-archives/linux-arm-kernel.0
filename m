From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Wed, 4 Jan 2012 20:21:19 +0100
Subject: [PATCH 1/2] mach-sa1100: fix sched_clock breakage
In-Reply-To: <1325672503-16690-1-git-send-email-linus.walleij@linaro.org>
References: <1325672503-16690-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120104192119.GC5154@Boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thx :)

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

On Wed, Jan 04, 2012 at 11:21:43AM +0100, Linus Walleij wrote:
> Fixed up a simple typo in the runtime sched_clock conversion
> so we compile again.
> 
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-sa1100/time.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
> index 1ee6d4c..69e3353 100644
> --- a/arch/arm/mach-sa1100/time.c
> +++ b/arch/arm/mach-sa1100/time.c
> @@ -19,7 +19,7 @@
>  #include <asm/sched_clock.h>
>  #include <mach/hardware.h>
>  
> -static u32 notrace sa100_read_sched_clock(void)
> +static u32 notrace sa1100_read_sched_clock(void)
>  {
>  	return OSCR;
>  }
> -- 
> 1.7.6.4
