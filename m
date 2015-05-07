From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 May 2015 10:18:49 +0200
Subject: [PATCH 2/3] gpio: Add GPIO support for Broadcom STB SoCs
In-Reply-To: <1430901477-10678-3-git-send-email-gregory.0xf0@gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <1430901477-10678-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1430986729.8171.41.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Wed, 2015-05-06 at 01:37 -0700, Gregory Fong wrote:
> --- /dev/null
> +++ b/drivers/gpio/gpio-brcmstb.c

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think either the comment at the top of this file or
the ident used in the MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle
