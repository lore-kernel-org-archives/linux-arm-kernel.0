From: pma@sysgo.com (Pavel Machek)
Date: Wed, 15 Jun 2011 14:30:13 +0200
Subject: sdhci-esdhc-imx -- MMC 10x slower than it should be
In-Reply-To: <20110615105318.GB3097@pengutronix.de>
References: <20110615094001.GA21137@pma.sysgo.com>
	<20110615105318.GB3097@pengutronix.de>
Message-ID: <20110615123013.GA29886@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> > not what it should be; it is about 10x lower in fact.
> 
> Which SoC? 25/35/51/53?

It is on

Hardware        : Freescale MX25 3-Stack Board
Revision        : 25010

...so MX25 AFAICT.

> > Any ideas why it is slow?
> 
> Your board polls for card-detect, Shawn recently sent a series which
> lets you fix that for mx5.

Thanks, I'll check.
								Pavel
