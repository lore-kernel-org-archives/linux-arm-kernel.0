From: davem@davemloft.net (David Miller)
Date: Sun, 05 Jun 2011 14:08:01 -0700 (PDT)
Subject: [PATCH v2 1/5] ep93xx: set DMA masks for the ep93xx_eth
In-Reply-To: <20110605085948.GB16018@acer>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<20110605083445.GT16318@ibawizard.net>
	<20110605085948.GB16018@acer>
Message-ID: <20110605.140801.1144137337172959622.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Sun, 5 Jun 2011 11:59:48 +0300

> It looks like David Miller (CC'd) has been taking care of ep93xx_eth.c maybe
> he knows this better.

Someone needs to step up and take over as the real maintainer of this
driver.  The way the driver is currently being hacked on is
unsustainable.
