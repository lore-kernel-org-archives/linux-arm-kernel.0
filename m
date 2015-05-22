From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 22 May 2015 12:30:53 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
Message-ID: <1432290653.27695.97.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Again, just a nit: a license mismatch.

On Thu, 2015-05-21 at 22:37 +0530, Kedareswara rao Appana wrote:

> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.

> +MODULE_LICENSE("GPL v2");

As I said in the message I sent a short while ago: here too I think that
either the comment at the top of this file or the ident used in the
MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle
