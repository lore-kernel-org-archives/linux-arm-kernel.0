From: marex@denx.de (Marek Vasut)
Date: Sat, 19 Sep 2015 05:08:55 +0200
Subject: [PATCH linux-next 1/4] mtd: spi-nor: remove unused
 read_xfer/write_xfer hooks
In-Reply-To: <719ad7cc8bf6df151dd799cd4f13292fd9471079.1442590224.git.cyrille.pitchen@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
 <719ad7cc8bf6df151dd799cd4f13292fd9471079.1442590224.git.cyrille.pitchen@atmel.com>
Message-ID: <201509190508.55496.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 18, 2015 at 05:49:25 PM, Cyrille Pitchen wrote:
> struct spi_nor_xfer_cfg and read_xfer/write_xfer hooks were never used by
> any driver. Do some cleanup by removing them.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Right, if this will ever be needed, it can be re-added.

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
