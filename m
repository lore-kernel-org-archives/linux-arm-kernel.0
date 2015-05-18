From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 18 May 2015 10:46:37 +0200
Subject: [PATCH net-next v3 2/2] net: Adding support for Cavium ThunderX
 network controller
In-Reply-To: <1431747401-20847-3-git-send-email-aleksey.makarov@auriga.com>
References: <1431747401-20847-1-git-send-email-aleksey.makarov@auriga.com>
 <1431747401-20847-3-git-send-email-aleksey.makarov@auriga.com>
Message-ID: <1431938797.2204.12.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Fri, 2015-05-15 at 20:36 -0700, Aleksey Makarov wrote:
> --- /dev/null
> +++ b/drivers/net/ethernet/cavium/thunder/nic_main.c

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.

This states the license is GPL v2 or later. (The other files used for
this module contain an identical comment.)

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
just GPL v2. So I think that either the license used in the comment at
the top of those files or the ident used in the MODULE_LICENSE() macro
needs to change.

Ditto for the thunder_bgx.ko and the nicvf.ko module.

Thanks,


Paul Bolle
