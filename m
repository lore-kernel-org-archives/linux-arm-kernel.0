From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 14:05:42 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120430055825.GA7926@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <20120430055825.GA7926@pengutronix.de>
Message-ID: <201204301405.42621.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Mon, Apr 30, 2012 at 12:36:08AM +0200, Marek Vasut wrote:
> > This sets the bus to run at 400kHz, prior to this,
> > the bus frequency was undefined.
> 
> Not exactly. The default values let it run at 100kHz.

Have you tried dumping the default values and comparing it with the values for 
100kHz in the manual?

> Since not all
> slaves support 400kHz, I have to NACK this one. Making it configurable
> is the way to go here.

All right, that's a good point.
> 
> Thanks,
> 
>    Wolfram

Best regards,
Marek Vasut
