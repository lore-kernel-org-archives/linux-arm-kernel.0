From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 14 Jul 2011 22:00:53 +0200
Subject: [RFC 0/6] watchdog drivers converted to the new framework
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F383E05BCD@AUSP01VMBX24.collaborationhost.net>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05B65@AUSP01VMBX24.collaborationhost.net>
	<20110714182734.GA31082@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05BCD@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110714200053.GC31082@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 01:42:02PM -0500, H Hartley Sweeten wrote:
> On Thursday, July 14, 2011 11:28 AM, Wolfram Sang wrote:
> >> I would also like to convert this driver into a proper platform_driver using
> >> ioremap'ed addresses instead of the static mappings.  Converting the driver
> >> to the new watchdog framework would make this a bit cleaner.
> >
> > Try managed devices (devm_* and friends) for an extra cleanup bonus.
> 
> Already done, just waiting for the framework... ;-)

Nice :) Did you use my conversion-guide as a reference? Any comments if so?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110714/55026e44/attachment.sig>
