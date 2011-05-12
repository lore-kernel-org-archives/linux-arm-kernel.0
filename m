From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2011 00:43:26 -0700
Subject: [PATCH 06/13] clocksource: add common mmio clocksource
In-Reply-To: <20110510084648.GA31122@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
	<20110510083841.GF30963@pengutronix.de>
	<20110510084648.GA31122@n2100.arm.linux.org.uk>
Message-ID: <20110512074325.GE31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110510 01:44]:
> On Tue, May 10, 2011 at 10:38:41AM +0200, Sascha Hauer wrote:
> > You forgot to initialize cs->reg. With this:
> 
> Damnit.  Fixed.
> 
> > Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

With cs->reg initialization and CONFIG_OMAP_MPU_TIMER=y things
boot tested on omap1 osk:

Tested-by: Tony Lindgren <tony@atomide.com>
