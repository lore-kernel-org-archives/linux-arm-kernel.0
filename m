From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Aug 2016 15:30:01 +0300
Subject: [PATCH] usb: chipidea: delete an useless header file
In-Reply-To: <20160819120544.651-1-jszhang@marvell.com>
References: <20160819120544.651-1-jszhang@marvell.com>
Message-ID: <3abe437c-7fab-339d-ad66-8db2456fbdb0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 8/19/2016 3:05 PM, Jisheng Zhang wrote:

> <linux/phy.h> is for net phy drivers, we don't need it.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/chipidea/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 69426e6..ae12595 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -62,7 +62,6 @@
>  #include <linux/usb/chipidea.h>
>  #include <linux/usb/of.h>
>  #include <linux/of.h>
> -#include <linux/phy.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/ehci_def.h>

    You're deleting an #include, not a file (as you say in the subject).

MBR, Sergei
