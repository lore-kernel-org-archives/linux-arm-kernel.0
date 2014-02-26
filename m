From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 14:32:14 +0000
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <20140226140632.GG6865@pengutronix.de>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140226111507.GW21483@n2100.arm.linux.org.uk>
 <20140226134605.GF6865@pengutronix.de>
 <20140226135352.GY21483@n2100.arm.linux.org.uk>
 <20140226140632.GG6865@pengutronix.de>
Message-ID: <20140226143213.GZ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:06:32PM +0100, Uwe Kleine-K?nig wrote:
> Looks reasonable. Maybe we can also get rid of PLAT_PHYS_OFFSET then.

I don't think so - try grep.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
