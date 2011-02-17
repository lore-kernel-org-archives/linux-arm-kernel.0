From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Feb 2011 09:34:33 +0000
Subject: [PATCH V3 1/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <ad969bd6-87bb-4910-a04a-d680e90d69af@VA3EHSMHS009.ehs.local>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<ad969bd6-87bb-4910-a04a-d680e90d69af@VA3EHSMHS009.ehs.local>
Message-ID: <20110217093433.GB22961@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

One nitpick, otherwise looks nice.

Jamie

On Wed, Feb 16, 2011 at 09:11:53AM -0700, John Linn wrote:
> diff --git a/arch/arm/mach-xilinx/common.h b/arch/arm/mach-xilinx/common.h
> new file mode 100644
> index 0000000..9a7cf65
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/common.h
> @@ -0,0 +1,30 @@
> +/* arch/arm/mach-xilinx/common.h
> + *
> + * This file contains common function prototypes to avoid externs
> + * in the c files.
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MACH_XILINX_COMMON_H__
> +#define __MACH_XILINX_COMMON_H__
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>

You don't appear to use the contents of platform_device.h in here so you 
could probably drop this include.
