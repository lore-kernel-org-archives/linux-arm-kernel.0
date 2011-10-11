From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 11 Oct 2011 17:27:38 +0200
Subject: TX28 drivers - Please help
In-Reply-To: <4E9453A5.2000501@prolan.hu>
References: <4E9453A5.2000501@prolan.hu>
Message-ID: <20111011152738.GB18273@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Oct 11, 2011 at 04:33:09PM +0200, Peter Rusko wrote:
> We'd like to use the Ka-Ro TX28 module in a device with our company.
> As I could see, not all the features of it's processor are supported.
> I have already added some of them using the Freescale version just to
> see that things are working, but the code became really messy. So I've
> decided to restart, and this time I'd like to commit the changes to
> the mainline kernel.

This is in general a good idea :-)

> We have already designed a company board supporting the TX28 module.
> The first problem I don't know how to do well is to separate the
> module and the baseboard.

Uwe proposed a baseboard abstraction patch some time ago (should be in
the list archives, drop me a note if you do not find it), because we
have the same issue on several TX28 customer boards as well (and with
other module hardware, like the Phytec modules). However, the general
position seems to be that this path will not lead into mainline, becasue
of oftree (which is, for the long term, of course the better solution).

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
