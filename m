From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 25 Mar 2014 11:06:32 +0100
Subject: [PATCH] net: micrel : ks8851-ml: add vdd-supply support
In-Reply-To: <20140324.003758.1244022408748408267.davem@davemloft.net>
References: <1395384768-8461-1-git-send-email-nm@ti.com>
 <20140324.003758.1244022408748408267.davem@davemloft.net>
Message-ID: <20140325100632.GB14810@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 24, 2014 at 12:37:58AM -0400, David Miller wrote:
> From: Nishanth Menon <nm@ti.com>
> Date: Fri, 21 Mar 2014 01:52:48 -0500
> 
> > Few platforms use external regulator to keep the ethernet MAC supplied.
> > So, request and enable the regulator for driver functionality.
> > 
> > Fixes: 66fda75f47dc (regulator: core: Replace direct ops->disable usage)
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Suggested-by: Markus Pargmann <mpa@pengutronix.de>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Applied, thanks.
> 

The two regulator patches for enable and disable are going into the
stable trees so this should also be submitted to stable for 3.10 to
3.13.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/9409b7fe/attachment.sig>
