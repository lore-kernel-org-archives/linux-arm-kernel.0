From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 13:44:26 +0100
Subject: [PATCH 2/5] ARM: S5PV210: Add keypad device helpers
In-Reply-To: <4BFFAE4E.2040508@samsung.com>
References: <4BFFAE4E.2040508@samsung.com>
Message-ID: <20100528124426.GA8230@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 08:51:42PM +0900, Joonyoung Shim wrote:
> diff --git a/arch/arm/mach-s5pv210/setup-keypad.c b/arch/arm/mach-s5pv210/setup-keypad.c
> new file mode 100644
> index 0000000..03a9de1
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-keypad.c
> @@ -0,0 +1,34 @@
> +/*
> + * linux/arch/arm/mach-s5pv210/setup-keypad.c
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +
> +#include <mach/gpio.h>

linux/gpio.h
