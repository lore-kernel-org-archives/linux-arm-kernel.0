From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 16:12:25 +0100
Subject: [PATCH v5 07/11] ARM: imx: add msl support for imx7d
In-Reply-To: <1429628007-8892-8-git-send-email-Frank.Li@freescale.com>
References: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
 <1429628007-8892-8-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150421151225.GZ12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 10:53:23PM +0800, Frank.Li at freescale.com wrote:
> diff --git a/arch/arm/mach-imx/mx7.h b/arch/arm/mach-imx/mx7.h
> new file mode 100644
> index 0000000..bfef936
> --- /dev/null
> +++ b/arch/arm/mach-imx/mx7.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + *  * This program is free software; you can redistribute it and/or modify
> + *   * it under the terms of the GNU General Public License version 2 as
> + *    * published by the Free Software Foundation.
> + *     */

Something obviously went wrong here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
