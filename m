From: davem@davemloft.net (David Miller)
Date: Sat, 28 Apr 2012 21:49:28 -0400 (EDT)
Subject: [PATCH 2/2] net/at91_ether: use gpio_to_irq for phy IRQ line
In-Reply-To: <cfc991548b5b73c8038f41877da1cd0104945cf5.1335435759.git.nicolas.ferre@atmel.com>
References: <3ad9b1273c4f30d42dcc3bdf6d03470111246f14.1335435759.git.nicolas.ferre@atmel.com>
 <cfc991548b5b73c8038f41877da1cd0104945cf5.1335435759.git.nicolas.ferre@atmel.com>
Message-ID: <20120428.214928.225764794994822879.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 26 Apr 2012 12:30:43 +0200

> Use the gpio_to_irq() function to retrieve the phy IRQ line
> from the GPIO pin specification.
> This fix is needed now that we have moved to irqdomains on AT91.
> 
> Reported-by: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to net-next.
