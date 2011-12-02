From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 02 Dec 2011 14:49:51 +0530
Subject: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
In-Reply-To: <1321809555-13833-4-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-4-git-send-email-hvaibhav@ti.com>
Message-ID: <4ED89837.6070901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[..]
> diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
> new file mode 100644
> index 0000000..5299287
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
> @@ -0,0 +1,357 @@
> +/*
> + * AM33XX Power Management register bits
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
> +#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
> +
> +#include "prm.h"
> +
> +/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
> +#define AM33XX_ABBOFF_ACT_EXPORT_SHIFT			1
> +#define AM33XX_ABBOFF_ACT_EXPORT_MASK			BITFIELD(1, 1)

This seems like an output from an old autogen script. The BITFIELD macro
does not exist anymore.
