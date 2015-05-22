From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 22 May 2015 12:10:14 +0200
Subject: [PATCH v6] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1432228025-6515-1-git-send-email-appanad@xilinx.com>
References: <1432228025-6515-1-git-send-email-appanad@xilinx.com>
Message-ID: <1432289414.27695.90.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Thu, 2015-05-21 at 22:37 +0530, Kedareswara rao Appana wrote:
> --- /dev/null
> +++ b/drivers/dma/xilinx/xilinx_dma.c

> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
just GPL v2. So I think that either the comment at the top of this file
or the ident used in the MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle
