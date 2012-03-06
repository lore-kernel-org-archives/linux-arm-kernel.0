From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Tue, 06 Mar 2012 21:48:36 +0300
Subject: [PATCH] pinctrl: include machine header to core.h
In-Reply-To: <1331038557-1398-1-git-send-email-linus.walleij@stericsson.com>
References: <1331038557-1398-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F565C04.1030202@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/06/2012 03:55 PM, Linus Walleij wrote:

> From: Linus Walleij<linus.walleij@linaro.org>

> struct pinctrl_setting contains an enum pinctrl_map_type
> field, so we need to include machine.h. Also fix kerneldoc
> to indicate that the pinctrl_setting is about both muxing
> and other config.

    I don't see where you touch kernel-doc...

> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   drivers/pinctrl/core.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> index 5b3ff13..42fb0ea 100644
> --- a/drivers/pinctrl/core.h
> +++ b/drivers/pinctrl/core.h
> @@ -12,6 +12,7 @@
>   #include<linux/mutex.h>
>   #include<linux/radix-tree.h>
>   #include<linux/pinctrl/pinconf.h>
> +#include<linux/pinctrl/machine.h>
>
>   struct pinctrl_gpio_range;

WBR, Sergei
