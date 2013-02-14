From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Feb 2013 10:56:11 +0000
Subject: [PATCH v2 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130214105611.GG17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:32PM +0100, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Just be aware that PXA has a "gpio reset" facility which is used for SoC
reset - see arch/arm/mach-pxa/reset.c

The use of gpio-reset would be ambiguous... or maybe PXA's usage could be
combined somehow with this?
