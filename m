From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 19:05:08 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <20100203105444.GG11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E9602@mi8nycmail19.Mi8.com>
	<20100203105444.GG11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B7877B@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > It appears these GPIO_P* macros are only used here.  Can the macros
> > be modified to create the (void __iomem *) directly?
> If GPIO_P* macros are only used here, maybe better define them in this
> file?

Some of the macros of the GPIO and muxing block are used in board/plat
files. It seemed logical to keep all those defines in the same area
(platform.h) instead of having some there and some in gpiolib.c.
