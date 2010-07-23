From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 22:15:52 +0100
Subject: [PATCH 07/11] ARM: omap: move omapfb_reserve_sram() to .init.text
In-Reply-To: <1279915120-4373-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1279915120-4373-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100723211552.GE750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 09:58:30PM +0200, Uwe Kleine-K?nig wrote:
> omapfb_reserve_sram() is only called by omap_detect_sram() which lives in
> .init.text.  So this is save for omapfb_reserve_sram(), too.

NAK.  (same reason.)
