From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 6 Jan 2015 18:14:12 +0800
Subject: [PATCH] sound: soc: atmel sam9g20_wm8731: remove useless include
In-Reply-To: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54ABB574.30602@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre Belloni,

On 01/06/2015 05:21 PM, Alexandre Belloni wrote:
> A mach/ header is included but never used. Simply remove it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks for your patch.

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/sam9g20_wm8731.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 66b66d0e7514..531728975bbb 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -47,7 +47,6 @@
>   #include <sound/soc.h>
>
>   #include <asm/mach-types.h>

Btw, do you consider to remove this also?

> -#include <mach/hardware.h>
>
>   #include "../codecs/wm8731.h"
>   #include "atmel-pcm.h"
>

Best Regards,
Bo Shen
