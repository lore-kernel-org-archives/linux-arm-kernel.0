From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 11 Mar 2015 12:10:23 +0100
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
References: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
 <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426072223.4244.93.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-10 at 16:41 +0100, Sascha Hauer wrote:
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -0,0 +1,345 @@
> +/*
> + * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

So you probably want
    MODULE_LICENSE("GPL v2");

here.


Paul Bolle
