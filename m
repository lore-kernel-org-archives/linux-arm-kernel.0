From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 17 Sep 2018 20:03:21 +0300
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
In-Reply-To: <20180911154007.17195-2-tudor.ambarus@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
Message-ID: <9953d6e5-1049-5645-31e3-7c05071c09aa@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Boris,

On 09/11/2018 06:40 PM, Tudor Ambarus wrote:
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c

[cut]

>  /*
I missed to use the opening comment mark for kernel-doc comments: "/**". This
observation applies to all newly introduced function descriptions, in this patch
and in the next as well.
> + * spi_nor_div_by_erase_size() - calculate remainder and update new dividend
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + * @dividend:	dividend value
> + * @remainder:	pointer to u32 remainder (will be updated)
> + *
> + * Returns two values: remainder and the new dividend

I should have used "Return: describe the return value" in order to be aligned
with the example from kernel-doc. This also applies to most of the function
descriptions.

[cut]

> +/*
> + *spi_nor_init_uniform_erase_map() - Initialize uniform erase map

add a space after that "*"

I will gladly submit a new version if there are no other comments. Please let me
know.

Cheers,
ta
