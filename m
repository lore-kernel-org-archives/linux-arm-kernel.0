From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 29 Nov 2010 14:20:34 +0100
Subject: [PATCH 3/3] mtd: FSMC NAND fix obvious speling errors
In-Reply-To: <1291035147-17840-1-git-send-email-linus.walleij@stericsson.com>
References: <1291035147-17840-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101129132033.GE20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

$SUBJECT ~= s/speling/spelling/ :-)

Uwe

On Mon, Nov 29, 2010 at 01:52:27PM +0100, Linus Walleij wrote:
> Fix spelling in the interface file.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  include/linux/mtd/fsmc.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
> index f589f29..8a2b75e 100644
> --- a/include/linux/mtd/fsmc.h
> +++ b/include/linux/mtd/fsmc.h
> @@ -27,7 +27,7 @@
>  
>  /*
>   * The placement of the Command Latch Enable (CLE) and
> - * Address Latch Enable (ALE) is twised around in the
> + * Address Latch Enable (ALE) is twisted around in the
>   * SPEAR310 implementation.
>   */
>  #if defined(CONFIG_MACH_SPEAR310)
> @@ -62,7 +62,7 @@ struct fsmc_nor_bank_regs {
>  
>  /* ctrl_tim register definitions */
>  
> -struct fsms_nand_bank_regs {
> +struct fsmc_nand_bank_regs {
>  	uint32_t pc;
>  	uint32_t sts;
>  	uint32_t comm;
> @@ -78,7 +78,7 @@ struct fsms_nand_bank_regs {
>  struct fsmc_regs {
>  	struct fsmc_nor_bank_regs nor_bank_regs[FSMC_MAX_NOR_BANKS];
>  	uint8_t reserved_1[0x40 - 0x20];
> -	struct fsms_nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
> +	struct fsmc_nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
>  	uint8_t reserved_2[0xfe0 - 0xc0];
>  	uint32_t peripid0;			/* 0xfe0 */
>  	uint32_t peripid1;			/* 0xfe4 */
> -- 
> 1.7.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
