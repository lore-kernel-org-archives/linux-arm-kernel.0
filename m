From: robert@schwebel.de (Robert Schwebel)
Date: Tue, 10 Jul 2012 16:09:11 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201207091758.22788.marex@denx.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <201207091307.35860.marex@denx.de>
 <20120709120523.GG1296@pengutronix.de>
 <201207091758.22788.marex@denx.de>
Message-ID: <20120710140911.GK20456@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 05:58:22PM +0200, Marek Vasut wrote:
> > The kernel should work for all users, not only for the majority, so:
> > Better safe than sorry.
> >
> > Also, defaults should make the system work. Tuning can be done later by
> > somebody who understands what is needed.
> >
> > And frankly, this attitude which made you add a potential regression is
> > worrisome. I'd suggest to give stability a higher priority.
>
> I believe you misunderstood my intention. Setting it to 400kHz was done because
> it's what most people will use, therefore avoiding duplication (most of the
> board files will override this setting now). All right, your sane defaults here
> can be applied, I won't argue.

I think all I2C chips support 100 kHz, but only selected ones support
400 kHz.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
