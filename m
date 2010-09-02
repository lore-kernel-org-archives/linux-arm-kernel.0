From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 09:45:41 +0100
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100902054630.GB14214@pengutronix.de>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
	<20100901111846.GF22790@game.jcrosoft.org>
	<20100901150112.GF11107@pengutronix.de>
	<20100901231849.GB25860@n2100.arm.linux.org.uk>
	<20100902054630.GB14214@pengutronix.de>
Message-ID: <20100902084541.GC26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 07:46:30AM +0200, Uwe Kleine-K?nig wrote:
> I guess the first is simple, the rest trivial, no?

Stop it.  Just accept that we don't want clk_add_alias to be __init.
