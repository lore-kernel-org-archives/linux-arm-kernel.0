From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 25 Mar 2011 16:39:48 +0100
Subject: [ PATCH V2  0/7] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <19852.46690.924051.229009@ipc1.ka-ro>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>
	<19852.46690.924051.229009@ipc1.ka-ro>
Message-ID: <20110325153948.GE3302@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Further the 'RSVD' entries should be removed from the register
> definitions (even if they are generated from the XML).

Even more, all unused defines should go.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110325/86111f47/attachment.sig>
