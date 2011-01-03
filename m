From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 3 Jan 2011 16:29:39 +0100
Subject: [PATCH 02/04] ARM i.MX25 Add SIM driver
In-Reply-To: <4D21E53E.2050809@fqingenieria.es>
References: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
	<20110103130551.GA24408@pengutronix.de>
	<4D21E53E.2050809@fqingenieria.es>
Message-ID: <20110103152939.GB24398@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Regarding if this driver can fit into mainline, I agree that the
> kernel is not the right place to contain a smartcard API. There are
> other projects doing that quite well (muscle, opensc, ...). But in
> fact, the idea of this driver is not to give a smartcard API but
> support the I.MX25 SIM core, which is explicitly hardware dependant.

Juergen Beisert also wrote a driver for it and you can read the
discussions about mainlining strategies here:

https://lkml.org/lkml/2010/5/7/214
http://www.opensc-project.org/pipermail/opensc-devel/2010-May/014225.html

Patches for opensc:

http://www.opensc-project.org/pipermail/opensc-devel/2010-May/014271.html

IIRC the direction was okay, just some obstacles left.

Kind regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110103/5756d247/attachment.sig>
