From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 13 Jun 2010 07:28:31 +0200
Subject: [PATCH 1/4] net/phy/marvell: Expose IDs and flags in a .h and
	add dns323 LEDs setup flag
In-Reply-To: <1276391423.1962.263.camel@pasglop>
References: <1276391423.1962.263.camel@pasglop>
Message-ID: <20100613052831.GA17012@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 11:10:23AM +1000, Benjamin Herrenschmidt wrote:
> This moves the various known Marvell PHY IDs to include/linux/marvell_phy.h
> along with dev_flags definitions for use by the driver.
> 
> I then added a flag that changes the PHY init code to setup the LEDs
> config to the values needed to operate a dns323 rev C1 NAS.
> 
> I moved the existing "resistance" flag to the .h as well, though I've
> been unable to find whoever sets this to convert it to use that constant.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

That should do for now.

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100613/8be21569/attachment.sig>
