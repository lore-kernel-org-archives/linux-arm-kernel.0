From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 2 Mar 2017 06:48:34 -0800
Subject: [PATCHv2 09/14] watchdog: hpwdt: Use set_memory.h header
In-Reply-To: <1488413706-9739-10-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-10-git-send-email-labbott@redhat.com>
Message-ID: <e99102e0-ae16-9720-a541-75e09bc0b68d@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2017 04:15 PM, Laura Abbott wrote:
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 70c7194..67fbe35 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -34,7 +34,7 @@
>  #include <linux/nmi.h>
>  #include <linux/kdebug.h>
>  #include <linux/notifier.h>
> -#include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  #endif /* CONFIG_HPWDT_NMI_DECODING */
>  #include <asm/nmi.h>
>  #include <asm/frame.h>
>
