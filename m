From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Feb 2011 18:30:32 +0100
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110212183726.GC9821@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<201102121107.17779.arnd@arndb.de>
	<20110212183726.GC9821@S2100-06.ap.freescale.net>
Message-ID: <201102121830.32387.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 February 2011 19:37:27 Shawn Guo wrote:
> > If you use a flattened device tree, you can avoid the need for
> > platform data by adding the phandle of the dma engine device to
> > a property of the mmc driver, along with the channel number inside
> > of that device. I think that would be the cleanest approach, but
> > some people still need to be convinced that changing drivers to
> > use fdt data is the right direction for ARM.
> > 
> Could we keep the current the approach for now and go to the cleanest
> way directly when Grant's dt patches get merged?

Sounds good to me. If you are planning to use device trees anyway,
I don't have a problem with leaving it your way in the meantime.

	Arnd
