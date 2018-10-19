From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:05:40 +0300
Subject: [PATCH 04/15] Platform: OLPC: Remove an unused include
In-Reply-To: <20181010172300.317643-5-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-5-lkundrak@v3.sk>
Message-ID: <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Also, the header is x86 specific, while there are non-x86 OLPC machines.

Same concern. as per patch 2.

Also, you might want to sort headers in alphabetical order.

>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index f99b183d5296..35a21c66cd0d 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -15,7 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
>
>  struct ec_cmd_desc {
>         u8 cmd;
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
