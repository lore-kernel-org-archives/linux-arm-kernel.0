From: davem@davemloft.net (David Miller)
Date: Sat, 28 Apr 2012 21:49:12 -0400 (EDT)
Subject: [PATCH 1/2] AT91: Remove fixed mapping for AT91RM9200 ethernet
In-Reply-To: <3ad9b1273c4f30d42dcc3bdf6d03470111246f14.1335435759.git.nicolas.ferre@atmel.com>
References: <3ad9b1273c4f30d42dcc3bdf6d03470111246f14.1335435759.git.nicolas.ferre@atmel.com>
Message-ID: <20120428.214912.1328835829329133918.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 26 Apr 2012 12:30:42 +0200

> From: Andrew Victor <avictor.za@gmail.com>
> 
> The AT91RM9200 Ethernet controller still has a fixed IO mapping.
> So:
> * Remove the fixed IO mapping and AT91_VA_BASE_EMAC definition.
> * Pass the physical base-address via platform-resources to the driver.
> * Convert at91_ether.c driver to perform an ioremap().
> * Ethernet PHY detection needs to be performed during the driver
> initialization process, it can no longer be done first.
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to net-next.
