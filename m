From: nm@ti.com (Nishanth Menon)
Date: Thu, 09 Dec 2010 10:45:27 -0600
Subject: [PATCH 2/8] arm: omap: add sdram-nokia.h
In-Reply-To: <1291912764-12823-3-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
	<1291912764-12823-3-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <4D0107A7.80900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen had written, on 12/09/2010 10:39 AM, the following:
[...]
> diff --git a/arch/arm/mach-omap2/sdram-nokia.h b/arch/arm/mach-omap2/sdram-nokia.h
> new file mode 100644
> index 0000000..ee63da5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sdram-nokia.h
> @@ -0,0 +1,12 @@
> +/*
> + * SDRC register values for Nokia boards
> + *
> + * Copyright (C) 2010 Nokia
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +struct omap_sdrc_params *nokia_get_sdram_timings(void);
> +
Minor comment: Header guard missing. maybe nice to add #ifndef, #def, 
#endif.

Regards,
Nishanth Menon
