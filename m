From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 16 Jun 2015 09:34:40 +0200
Subject: [PATCH linux-next 2/2] mfd: flexcom: add a driver for Atmel
 Flexible Serial Communication Unit
In-Reply-To: <e85ceae28a0b382b12b809ac7cca891fcb7ac846.1434386119.git.cyrille.pitchen@atmel.com>
References: <cover.1434386119.git.cyrille.pitchen@atmel.com>
 <e85ceae28a0b382b12b809ac7cca891fcb7ac846.1434386119.git.cyrille.pitchen@atmel.com>
Message-ID: <1434440080.2069.49.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Mon, 2015-06-15 at 18:38 +0200, Cyrille Pitchen wrote:
> --- /dev/null
> +++ b/drivers/mfd/atmel-flexcom.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

This states the license is GPL v2 (or later)

> +MODULE_LICENSE("GPL v2");

According to include/linux/module.h this states the license is (just)
GPL v2. So I think that either the comment at the top of this file or
the ident used in the MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle 
