From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 09:19:54 +0100
Subject: [PATCH 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1425510624-22250-2-git-send-email-stefan@agner.ch>
References: <1425510624-22250-1-git-send-email-stefan@agner.ch>
 <1425510624-22250-2-git-send-email-stefan@agner.ch>
Message-ID: <1425543594.24292.189.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-05 at 00:10 +0100, Stefan Agner wrote:
> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -0,0 +1,730 @@

> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

So you probably want
    MODULE_LICENSE("GPL");

here.


Paul Bolle
