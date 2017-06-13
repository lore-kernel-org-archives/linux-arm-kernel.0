From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jun 2017 15:14:55 +0200
Subject: [PATCH] mtd: nand: atmel_nand: drop unused include
In-Reply-To: <20170613125842.16422-1-alexandre.belloni@free-electrons.com>
References: <20170613125842.16422-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170613151455.1b458499@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jun 2017 14:58:42 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The Atmel NAND driver doesn't used anything from
> linux/platform_data/atmel.h, stop including it.
> 

Applied.

Thanks,

Boris

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> index 3b2446896147..6bd61acfc2c8 100644
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -64,7 +64,6 @@
>  #include <linux/of_platform.h>
>  #include <linux/iopoll.h>
>  #include <linux/platform_device.h>
> -#include <linux/platform_data/atmel.h>
>  #include <linux/regmap.h>
>  
>  #include "pmecc.h"
