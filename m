From: wg@grandegger.com (Wolfgang Grandegger)
Date: Mon, 21 Jan 2013 09:56:24 +0100
Subject: [PATCH] net: fec: Add support for multiple phys on mdiobus
In-Reply-To: <1358757475-21035-1-git-send-email-s.hauer@pengutronix.de>
References: <1358757475-21035-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <50FD02B8.8080401@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 09:37 AM, Sascha Hauer wrote:
> There may be multiple phys on an mdio bus. This series adds support
> for this to the fec driver. I recently had a board which has a switch
> connected to the fec's mdio bus, so I had to pick the correct phy.

Pick one PHY from a switch port? Well, does a PHY-less (or fixed-link)
configuration for a switch not make more sense? Various ARM Ethernet
contoller drivers do not support it. I recently needed a hack for an
AT91 board.

Wolfgang.
