From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 22:09:12 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120430194313.GA28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204301405.42621.marex@denx.de> <20120430194313.GA28226@pengutronix.de>
Message-ID: <201204302209.12482.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > > This sets the bus to run at 400kHz, prior to this,
> > > > the bus frequency was undefined.
> > > 
> > > Not exactly. The default values let it run at 100kHz.
> > 
> > Have you tried dumping the default values and comparing it with the
> > values for 100kHz in the manual?
> 
> Yes, sure. Doesn't it work for you? I just rechecked and the values are
> okay. That being said, if you make it configurable for 400kHz, it would
> in deed be better to rewrite the values for 100kHz, too.

They were different for me ... did you configure the i2c bus in your bootloader 
possibly? Those values might have been written there since then ... I didn't run 
i2c in u-boot before booting linux.

Best regards,
Marek Vasut
