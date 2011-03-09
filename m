From: balajitk@ti.com (Krishnamoorthy, Balaji T)
Date: Wed, 9 Mar 2011 20:03:17 +0530
Subject: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
	flags for each cpu_... test
In-Reply-To: <20110308110904.23531.66727.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<20110308110904.23531.66727.stgit@otae.warmcat.com>
Message-ID: <AANLkTimTnEuH=H0w96dZLmqYPhGM2dN168JViC8wciuV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2011 at 4:39 PM, Andy Green <andy@warmcat.com> wrote:
> +/* struct omap_i2c_bus_platform_data .flags meanings */
> +
> +#define OMAP_I2C_FLAG_NO_FIFO 1
Hi,

Minor comment, Can you use
BIT(0) for 1, BIT(1) for 2 ... BIT (8) for 0x100

> +#define OMAP_I2C_FLAG_SIMPLE_CLOCK 2
> +#define OMAP_I2C_FLAG_16BIT_DATA_REG 4
> +#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE 8
> +#define OMAP_I2C_FLAG_APPLY_ERRATA_I207 0x10
> +#define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK 0x20
