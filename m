From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 26 Jan 2016 11:41:30 +0100
Subject: [PATCH V3 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1453722989-41622-2-git-send-email-blogic@openwrt.org>
References: <1453722989-41622-1-git-send-email-blogic@openwrt.org>
 <1453722989-41622-2-git-send-email-blogic@openwrt.org>
Message-ID: <1453804890.17181.93.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John,

On ma, 2016-01-25 at 12:56 +0100, John Crispin wrote:
> --- /dev/null
> +++ b/drivers/regulator/mt6323-regulator.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This states this file is licensed GPL v2 only.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this means "GNU Public License
v2 or later".

So I think there's a (subtle) mismatch between the license ident used
for this driver and the comment above.

Thanks,


Paul Bolle
