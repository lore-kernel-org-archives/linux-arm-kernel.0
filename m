From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 15:30:32 +0100
Subject: [PATCH 2/2] DMA: PL08x: fix channel pausing to timeout rather
	than lockup
In-Reply-To: <20110127123744.GA28855@n2100.arm.linux.org.uk>
References: <20110127123253.GC25968@n2100.arm.linux.org.uk>
	<20110127123744.GA28855@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimJ9jYsF9mW3W14UhAOmxFDAuuyiMC2Z6AE=Ppo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> If a transfer is initiated from memory to a peripheral, then data is
> fetched and the channel is marked busy. ?This busy status persists until
> the HALT bit is set and the queued data has been transfered to the
> peripheral. ?Waiting indefinitely after setting the HALT bit results in
> system lockups. ?Timeout this operation, and print an error when this
> happens.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
