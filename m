From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 09:46:48 +0100
Subject: [PATCH 06/13] clocksource: add common mmio clocksource
In-Reply-To: <20110510083841.GF30963@pengutronix.de>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
	<20110510083841.GF30963@pengutronix.de>
Message-ID: <20110510084648.GA31122@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 10:38:41AM +0200, Sascha Hauer wrote:
> You forgot to initialize cs->reg. With this:

Damnit.  Fixed.

> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks.
