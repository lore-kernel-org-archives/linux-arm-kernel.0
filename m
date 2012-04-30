From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 21:43:13 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <201204301405.42621.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <20120430055825.GA7926@pengutronix.de>
 <201204301405.42621.marex@denx.de>
Message-ID: <20120430194313.GA28226@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > This sets the bus to run at 400kHz, prior to this,
> > > the bus frequency was undefined.
> > 
> > Not exactly. The default values let it run at 100kHz.
> 
> Have you tried dumping the default values and comparing it with the values for 
> 100kHz in the manual?

Yes, sure. Doesn't it work for you? I just rechecked and the values are
okay. That being said, if you make it configurable for 400kHz, it would
in deed be better to rewrite the values for 100kHz, too.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/450aee0f/attachment.sig>
