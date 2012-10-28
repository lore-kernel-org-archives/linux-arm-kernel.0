From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 10:41:05 +0100
Subject: [PATCH v2 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <1351416634-3352-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351416634-3352-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121028104105.5aeaa784@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sun, 28 Oct 2012 10:30:33 +0100, Thomas Petazzoni wrote:
> Now that the drivers/irqchip/ directory has a minimal infrastructure
> to support the addition of irq controller driver, we move the irq
> controller driver for Armada 370 and Armada XP ARM SoCs from the
> arch/arm/mach-mvebu/ directory to the drivers/irqchip/ directory and
> update the irqchip infrastructure to take into account this new
> driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>

Grr, forgot -M when doing the format-patch, so it's showing a huge +/-
delta due to the code movement. Will repost an updated version of this
one.

Guess it's time to figure out how to make -M being the default for
format-patch here.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
