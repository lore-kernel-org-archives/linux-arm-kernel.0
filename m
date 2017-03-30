From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 30 Mar 2017 20:59:28 +0800
Subject: [PATCH] ARM: dts: imx6: ZII-RDU2: fix FEC node properties
In-Reply-To: <20170329133537.26028-1-l.stach@pengutronix.de>
References: <20170329133537.26028-1-l.stach@pengutronix.de>
Message-ID: <20170330125926.GD683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 03:35:37PM +0200, Lucas Stach wrote:
> These have been messed up during mainlining of the DT files.
> Fix them to be valid properties.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Shawn, if possible, it would be nice to squash this fix into the
> broken patch adding those DT files, but that's up to you.
> 8b44da415afc (ARM: dts: imx6: add ZII RDU2 boards)

Squashed it into "ARM: dts: imx6: add ZII RDU2 boards".

Shawn
