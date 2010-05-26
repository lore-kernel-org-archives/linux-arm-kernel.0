From: chasedouglas@gmail.com (Chase Douglas)
Date: Wed, 26 May 2010 08:54:50 -0400
Subject: [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
Message-ID: <1274878490.9346.38.camel@cndougla-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-26 at 17:09 +1200, Ryan Mallon wrote:
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
> new file mode 100644
> index 0000000..830c793
> --- /dev/null
> +++ b/sound/soc/ep93xx/ep93xx-i2s.h
> @@ -0,0 +1,25 @@
> +/*
> + * linux/sound/soc/ep93xx-i2s.h
> + * EP93xx I2S driver
> + *
> + * Copyright (C) 2010 Ryan Mallon <ryan@bluewatersys.com>
> + *  
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _EP93XX_SND_SOC_I2S_H
> +#define _EP93XX_SND_SOC_I2S_H
> +
> +/*
> + * These are the offsets for the LRDIV and SDIV fields in the syscon i2sclkdiv
> + * register.
> + */
> +#define EP93XX_I2S_LRDIV	17
> +#define EP93XX_I2S_SDIV		16

Looks like a minor ugly whitespace issue above.

-- Chase
