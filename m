From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 18 Jun 2015 15:10:10 +0200
Subject: [PATCH v2 3/7] mmc: mediatek: build as module
In-Reply-To: <1434629873-11668-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-4-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <CAPDyKFq-s+xFY0zxVP7SEEEWVLh83VQiMPjJseRXkparmQY7fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2015 at 14:17, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> while building as module with mn10300 it failed with:
>
> warning: data definition has no type or storage class
>         module_init(__driver##_init);
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Thanks for the patch. It's although already been fixed on my next branch.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 7c20f28..ea6ae36 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -33,6 +33,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sd.h>
>  #include <linux/mmc/sdio.h>
> +#include <linux/module.h>
>
>  #define MAX_BD_NUM          1024
>
> --
> 1.8.1.2
>
