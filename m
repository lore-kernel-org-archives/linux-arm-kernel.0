From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 17 Mar 2015 19:56:44 +0100
Subject: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
In-Reply-To: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
References: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1426618604.15575.3.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a license nit.

On Tue, 2015-03-17 at 13:28 +0800, Yuan Yao wrote:
> --- /dev/null
> +++ b/drivers/dma/fsl-qdma.c

> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And
    MODULE_LICENSE("GPL");

would match that statement.


Paul Bolle
