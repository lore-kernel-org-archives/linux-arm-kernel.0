From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 1 Jun 2017 15:35:35 +0100
Subject: [PATCH v3 3/9] mfd: tmio.h: support partition parser types
In-Reply-To: <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170601143535.s6ovk5ts3cbehw3f@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 01 Jun 2017, Andrea Adami wrote:

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

Please use kerneldoc instead.

>  };
>  
>  #define FBIO_TMIO_ACC_WRITE	0x7C639300

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
