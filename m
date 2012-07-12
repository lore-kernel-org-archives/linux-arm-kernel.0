From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:10:01 +0800
Subject: [PATCH 12/12] USB: chipidea: add imx usbmisc support
In-Reply-To: <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712071000.GC21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> --- /dev/null
> +++ b/drivers/usb/chipidea/imx_usbmisc.c
> @@ -0,0 +1,144 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <asm/io.h>
It should be linux/io.h
 
Thanks
Richard
