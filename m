From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 10:21:47 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411091548.GD3163@opensource.wolfsonmicro.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411091548.GD3163@opensource.wolfsonmicro.com>
Message-ID: <20120411092147.GW24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:15:49AM +0100, Mark Brown wrote:
> On Wed, Apr 11, 2012 at 04:45:29PM +0800, Richard Zhao wrote:
> > a clk, one already got the struct clk* pointer and could use it in
> > struct lookup.
> 
> How will you handle cases where one clock supplies another?

What has that got to do with clkdev (which is the topic in this thread)?
