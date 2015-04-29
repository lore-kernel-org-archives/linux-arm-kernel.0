From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 29 Apr 2015 10:42:19 +0200
Subject: [PATCH 2/2] Regulator: add driver for Freescale MC34708
In-Reply-To: <20150428141740.16243.79036.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
 <20150428141740.16243.79036.stgit@localhost>
Message-ID: <1430296939.2411.103.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Tue, 2015-04-28 at 16:17 +0200, Martin Fuzzey wrote:
> --- /dev/null
> +++ b/drivers/regulator/mc34708-regulator.c

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to inlcude/linux/module.h, this states the license is
(just) GPL v2. So I think either to comment at the top of this file or
the ident used in the MODULE_LICENSE() macro should be changed.

Thanks,


Paul Bolle
