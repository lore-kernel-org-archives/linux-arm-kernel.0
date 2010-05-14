From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 14 May 2010 17:56:31 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <20100514024915.GE30794@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
	<20100514024915.GE30794@pengutronix.de>
Message-ID: <20100514155631.GG4008@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> 
> Ping. Wim, did you notice this one? Shall the driver go via your tree or via
> the imx-tree along with the resource updates (with your ack)?

Yes, I saw this one. I started reviewing it, but didn't finish it yet.
Will let you know something when it's done.

Driver can go via my tree but since it's part of a series of other patches, it can also
go via the imx tree (which is probably preferred).

Kind regards,
Wim.
