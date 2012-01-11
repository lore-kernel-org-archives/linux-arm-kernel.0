From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 11 Jan 2012 11:43:39 +0100
Subject: [PATCH v4] MTD/GPMI bugfix : reset the BCH module when it is
 not MX23
In-Reply-To: <1326185340.8847.11.camel@sauron.fi.intel.com>
References: <1325647126-4281-1-git-send-email-b32955@freescale.com>
 <1326185340.8847.11.camel@sauron.fi.intel.com>
Message-ID: <20120111104339.GB2605@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 10:49:00AM +0200, Artem Bityutskiy wrote:
> On Wed, 2012-01-04 at 11:18 +0800, Huang Shijie wrote:
> > In MX28, if we do not reset the BCH module. The BCH module may
> > becomes unstable when the board reboots for several thousands times.
> > This bug has been catched in customer's production.
> > 
> > The patch adds some comments(some from Wolfram Sang), and fixes it now.
> > 
> > Also change gpmi_reset_block() to static.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Pushed to l2-mtd-2.6.git, thanks!

I somehow missed this patch, if it's not too late, you can add my

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120111/43116a71/attachment-0001.sig>
