From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Dec 2013 09:30:17 +0000 (UTC)
Subject: [PATCHv10 12/41] CLK: TI: add omap4 clock init file
In-Reply-To: <1385453182-24421-13-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-13-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312170923440.14039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> clk-44xx.c now contains the clock init functionality for omap4, including
> DT clock registration and adding of static clkdev entries.

...

> diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
> new file mode 100644
> index 0000000..3e2090b
> --- /dev/null
> +++ b/drivers/clk/ti/clk-44xx.c
> @@ -0,0 +1,328 @@
> +/*
> + * OMAP4 Clock data
> + *
> + * Copyright (C) 2009-2012 Texas Instruments, Inc.
> + * Copyright (C) 2009-2010 Nokia Corporation
> + *
> + * Paul Walmsley (paul at pwsan.com)

Please remove my name and E-mail address from this file.


- Paul
