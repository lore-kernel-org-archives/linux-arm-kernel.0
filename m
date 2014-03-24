From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Mar 2014 20:08:56 +0100
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <20140324184114.GK23076@pengutronix.de>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
 <20140324184114.GK23076@pengutronix.de>
Message-ID: <20140324190856.GA11532@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > +config I2C_EFM32
> > > +	tristate "EFM32 I2C controller"
> > > +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)
> > 
> > Is EFM32 DT only? Do we need the dependency on OF?
> yes, efm32 is DT only. Still for the COMPILE_TEST branch the OF is
> needed.

Really? of_* functions should have empty templates if OF is not
selected, I'd think.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/332c8e85/attachment.sig>
