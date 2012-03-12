From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 12 Mar 2012 20:02:41 +0100
Subject: [PATCH v7 0/4] USB: OHCI-HCD: Support for LPC32xx
In-Reply-To: <1331463219-23293-1-git-send-email-stigge@antcom.de>
References: <1331463219-23293-1-git-send-email-stigge@antcom.de>
Message-ID: <20120312190241.GA28087@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 11:53:35AM +0100, Roland Stigge wrote:
> These patches add support for the LPC32xx to the ohci-pnx4008 driver and make
> the driver use smbus functions.

Do you have a branch ready to test (USB driver fixes + mach additions)? I'd
like to test but I get lots of conflicts when adding the mach related stuff.
I probably have a different base?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/cc2d3541/attachment-0001.sig>
