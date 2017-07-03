From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Jul 2017 12:26:21 +0100
Subject: [PATCH v4 3/9] mfd: tmio.h: support partition parser types
In-Reply-To: <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
 <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170703112621.rd3ija3efqlq57rg@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please use the $SUBJECT line expected by the subsystem.

`git log --oneline -- $SUBSYSTEM` can help with this.

You also need a commit log.

> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mfd/tmio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index a1520d8..23bb069 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -139,6 +139,7 @@ struct tmio_nand_data {
>  	struct nand_bbt_descr	*badblock_pattern;
>  	struct mtd_partition	*partition;
>  	unsigned int		num_partitions;
> +	const char *const	*types;	/* names of parsers to use if any */

I'm okay with this if it's suits the MTD folk.

>  };
>  
>  #define FBIO_TMIO_ACC_WRITE	0x7C639300

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
