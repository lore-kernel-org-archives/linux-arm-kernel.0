From: robherring2@gmail.com (Rob Herring)
Date: Mon, 02 Apr 2012 07:58:38 -0500
Subject: [PATCH] ARM: pxa: pxa2xx-i2s: add io.h for IOMEM macro
In-Reply-To: <1333355048-732-1-git-send-email-Martin.Jansa@gmail.com>
References: <1333355048-732-1-git-send-email-Martin.Jansa@gmail.com>
Message-ID: <4F79A27E.1010509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2012 03:24 AM, Martin Jansa wrote:
> * fixes
>   sound/soc/pxa/pxa2xx-i2s.c:86:2: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]
>   sound/soc/pxa/pxa2xx-i2s.c:86:2: error: initializer element is not constant
>   after 23019a733bb83c8499f192fb428b7e6e81c95a34 removed IOMEM
>   definition from arch/arm/mach-pxa/include/mach/hardware.h
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  sound/soc/pxa/pxa2xx-i2s.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
> index 609abd5..d085837 100644
> --- a/sound/soc/pxa/pxa2xx-i2s.c
> +++ b/sound/soc/pxa/pxa2xx-i2s.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
> +#include <linux/io.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/initval.h>
