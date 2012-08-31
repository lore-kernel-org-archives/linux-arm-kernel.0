From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 31 Aug 2012 11:37:28 +0200
Subject: [PATCH v2 6/9] misc: Generic on-chip SRAM allocation driver
In-Reply-To: <1346405224-20399-7-git-send-email-p.zabel@pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
 <1346405224-20399-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1346405848.5316.11.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-31 at 11:27 +0200, Philipp Zabel wrote:
> This driver requests and remaps a memory region as configured in the
> device tree. It serves memory from this region via the genalloc API.
> 
> Other drivers can retrieve the genalloc pool from a phandle pointing
> to this drivers' device node in the device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/misc/Kconfig  |    8 ++++
>  drivers/misc/Makefile |    1 +
>  drivers/misc/sram.c   |  105 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/misc/sram.c

We now have drivers/memory, which seems to be a good place for this.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
