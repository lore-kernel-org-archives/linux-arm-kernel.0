From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 11:53:35 +0100
Subject: [PATCH] S5V310: I2C0/I2C1/I2C2 support
In-Reply-To: <20100730105535.GA15067@july>
References: <20100730105535.GA15067@july>
Message-ID: <20100731105335.GJ23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 07:55:35PM +0900, Kyungmin Park wrote:
> diff --git a/arch/arm/mach-s5pv310/setup-i2c0.c b/arch/arm/mach-s5pv310/setup-i2c0.c
> index d4f5a81..b14dea7 100644
> --- a/arch/arm/mach-s5pv310/setup-i2c0.c
> +++ b/arch/arm/mach-s5pv310/setup-i2c0.c
> @@ -1,4 +1,5 @@
> -/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
> +/*
> + * linux/arch/arm/mach-s5pv310/setup-i2c0.c
>   *
>   * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
> @@ -14,7 +15,14 @@
>  
>  struct platform_device; /* don't need the contents */
>  
> +#include <mach/gpio.h>

linux/gpio.h?

> diff --git a/arch/arm/mach-s5pv310/setup-i2c1.c b/arch/arm/mach-s5pv310/setup-i2c1.c
> new file mode 100644
> index 0000000..76099ff
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-i2c1.c
> @@ -0,0 +1,25 @@
> +/*
> + * linux/arch/arm/mach-s5pv310/setup-i2c1.c
> + *
> + * Copyright (C) 2010 Samsung Electronics Co., Ltd.
> + *
> + * I2C1 GPIO configuration.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +struct platform_device; /* don't need the contents */
> +
> +#include <mach/gpio.h>

linux/gpio.h ?

... etc ...
