From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Apr 2015 10:56:31 +0100
Subject: [PATCH 1/4] ARM: UniPhier: add basic support for UniPhier
 architecture
In-Reply-To: <1429170038-16757-2-git-send-email-yamada.masahiro@socionext.com>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150416095631.GY12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 04:40:35PM +0900, Masahiro Yamada wrote:
> diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
> new file mode 100644
> index 0000000..6b61f8d
> --- /dev/null
> +++ b/arch/arm/mach-uniphier/platsmp.c
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2015 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/sizes.h>
> +#include <linux/init.h>
> +#include <asm/io.h>

Please use linux/io.h rather than asm/io.h

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
