From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2011 23:33:11 -0700
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Message-ID: <20110623063311.GV23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110622 08:24]:
> Convert sa11x0 to use the generic CPU suspend/resume support, rather
          ^^^^^^
Should be omap34xx above.

> than implementing its own version.  Tested on 3430 LDP.

Nice job with this series Russell!

Tony
