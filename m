From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 15:52:06 +0200
Subject: [PATCH v4 1/2] ASoC: sam9g20_wm8731: remove useless mach/gpio.h
In-Reply-To: <cb4eece4e6fadca4627a869bfe6efb3d41c66700.1397468934.git.nicolas.ferre@atmel.com>
References: <cb4eece4e6fadca4627a869bfe6efb3d41c66700.1397468934.git.nicolas.ferre@atmel.com>
Message-ID: <53512E06.9080007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 11:54, Nicolas Ferre :
> This include file is about to disapear. In addition it is
> useless for this code. So it is time to remove it.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Mark,
> 
> This patch is needed before we integrate the folling one. It will allow us to
> remove the mach/gpio.h header file for AT91 and will be a move forward in the
> single zImage direction.
> 
> So, can you have a look and if you agree, we may add both in arm-soc during
> the 3.15-rc phase...

So, after discussion with Arnd, I take this series of two in our
at91-3.16-cleanup branch.

Bye,

> 
>  Thanks, bye
> 
>  sound/soc/atmel/sam9g20_wm8731.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 174bd546c08b..bb1149126c54 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -48,7 +48,6 @@
>  
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
> -#include <mach/gpio.h>
>  
>  #include "../codecs/wm8731.h"
>  #include "atmel-pcm.h"
> 


-- 
Nicolas Ferre
