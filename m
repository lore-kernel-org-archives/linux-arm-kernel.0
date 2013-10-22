From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Oct 2013 10:06:04 -0700
Subject: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
In-Reply-To: <1382446896-28436-2-git-send-email-sre@debian.org>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org>
Message-ID: <20131022170604.GP15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [131022 06:02]:
> This patch moves the handling of the chip's enable pin from the board
> code into the driver. It also updates all board-code files using the
> driver to incorporate this change.
> 
> This is needed for device tree support of the enable pin.

This seems safe to merge along with the other LED patches, the
changes to arch/arm/mach-omap2 should not conflict with anything.

So for the arch/arm/mach-omap2 changes:

Acked-by: Tony Lindgren <tony@atomide.com>
