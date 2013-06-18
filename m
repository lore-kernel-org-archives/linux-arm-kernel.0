From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 14:54:03 +0200
Subject: [PATCH] ARM: irqchip: add support for MOXA ART SoCs
In-Reply-To: <20130618103534.GW2718@n2100.arm.linux.org.uk>
References: <1371549584-7169-1-git-send-email-jonas.jensen@gmail.com>
 <20130618103534.GW2718@n2100.arm.linux.org.uk>
Message-ID: <201306181454.04011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Russell King - ARM Linux wrote:
> Is there a reason this isn't using the irq_chip_generic stuff which would
> eliminate all the above?

When I first reviewed the moxart code, the generic irqchip wasn't compatible
with the linear irq domain. However this has changed now and it should indeed
use that.

	Arnd
