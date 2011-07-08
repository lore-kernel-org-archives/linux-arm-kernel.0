From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jul 2011 11:02:37 +0200
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <20110708073119.GP29624@pengutronix.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<201106301555.19440.arnd@arndb.de>
	<20110708073119.GP29624@pengutronix.de>
Message-ID: <201107081102.38179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 July 2011 09:31:19 Uwe Kleine-K?nig wrote:
> > The init function is used only to set up iomux, so the logical replacement is
> > a pointer to the iomux data, and calling mxs_iomux_setup_multiple_pads
> > directly from the driver.
> Why not put the iomux stuff into the per-machine table and get rid of
> the init callback, too?

Sounds good to me.

	Arnd
