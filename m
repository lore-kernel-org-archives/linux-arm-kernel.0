From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 8 Sep 2010 22:31:27 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <20100908091149.GC29914@n2100.arm.linux.org.uk>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100902212145.GA15264@n2100.arm.linux.org.uk>
	<20100902212723.GC26319@n2100.arm.linux.org.uk>
	<20100903074806.GX14214@pengutronix.de>
	<20100903095504.GC13643@pengutronix.de>
	<20100908091149.GC29914@n2100.arm.linux.org.uk>
Message-ID: <20100908203127.GI10841@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Wed, Sep 08, 2010 at 10:11:49AM +0100, Russell King - ARM Linux wrote:
> > I looked into that and found some more issues.  I hope I catched them
> > all now.  While doing that removing the zreladdr lines was nearly for
> > free.  So I did that, too.
> > 
> > I couldn't determine who to cc: for the ARCH_H720X patch.  Russell, do
> > you maintain this platform?
> 
> Nope.

Sascha does probably maintain H720x. However, I'm not sure if there is
somebody out there who does still use it actively.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
