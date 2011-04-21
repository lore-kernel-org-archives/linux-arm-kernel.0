From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 16:29:48 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421103117.GB16776@sirena.org.uk>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110421103117.GB16776@sirena.org.uk>
Message-ID: <alpine.LFD.2.02.1104211629160.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Mark Brown wrote:
> That's not reliably the case, some systems have some of the clock tree
> (esepcialy the core parts of the tree) controlled by a system management
> unit which isn't memory mapped and it's common for I2C or SPI connected
> chips to be involved to some extent too.  One advantage we should be
> able to get from this framework is that it will be much easier to have
> standard drivers for off-SoC chips that could be shared.

Fair enough.
 
