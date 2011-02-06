From: ramaxlo@gmail.com (Ramax Lo)
Date: Sun, 6 Feb 2011 20:12:00 +0800
Subject: [PATCH 1/2] ARM: QQ2440 machine architecture
In-Reply-To: <20110202220530.GB2808@dandreoli.com>
References: <20110202220359.GA2808@dandreoli.com>
	<20110202220530.GB2808@dandreoli.com>
Message-ID: <AANLkTinR1-WBGjybS17zyf0PmPdPUDCdBx+nM9YL9qyk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Domenico,

2011/2/3 Domenico Andreoli <cavokz@gmail.com>:
> From: Domenico Andreoli <cavokz@gmail.com>
>
> Add core architecture support for QQ2440.
>
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
>

snip

> --- /dev/null ? 1970-01-01 00:00:00.000000000 +0000
> +++ arm-2.6.git/arch/arm/mach-s3c2440/mach-qq2440.c ? ? 2011-02-02 21:59:39.000000000 +0000
> @@ -0,0 +1,358 @@
> +/* linux/arch/arm/mach-s3c2440/mach-qq2440.c
> + *
> + * Copyright (c) 2011 Domenico Andreoli <cavokz@gmail.com>
> + * ? ? ?Based on mach-mini2440.c by Ramax Lo <ramaxlo@gmail.com>
> + *

The original author that added mini2440 support is Michel Pollet, not me,
although his partial work is based on mine.

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
