From: harvey.hunt@imgtec.com (Harvey Hunt)
Date: Fri, 1 Apr 2016 14:09:27 +0100
Subject: [PATCH 01/12] mtd: nand: remove unneeded of_mtd.h inclusions
In-Reply-To: <1459515272-31011-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56FE7307.6040903@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 01/04/16 13:54, Boris Brezillon wrote:
> Some drivers are including linux/of_mtd.h even if they don't use any of
> the of_get_nand_xxx() helpers.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/mtd/nand/jz4780_nand.c | 1 -
>   drivers/mtd/nand/lpc32xx_mlc.c | 1 -
>   drivers/mtd/nand/qcom_nandc.c  | 1 -
>   drivers/mtd/nand/sunxi_nand.c  | 1 -
>   drivers/mtd/nand/vf610_nfc.c   | 1 -
>   5 files changed, 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
> index e1c016c..23a1999 100644
> --- a/drivers/mtd/nand/jz4780_nand.c
> +++ b/drivers/mtd/nand/jz4780_nand.c
> @@ -17,7 +17,6 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/gpio/consumer.h>
> -#include <linux/of_mtd.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/mtd/mtd.h>

Looks good to me.

Acked-by: Harvey Hunt <harvey.hunt@imgtec.com>

Thanks,

Harvey
