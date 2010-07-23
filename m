From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 22:16:05 +0100
Subject: [PATCH 08/11] ARM: omap: move get_fbmem_region() to .init.text
In-Reply-To: <1279915120-4373-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1279915120-4373-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100723211605.GF750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 09:58:31PM +0200, Uwe Kleine-K?nig wrote:
> get_fbmem_region() is only called by omapfb_reserve_sdram() and
> omapfb_reserve_sram() that both live in .init.text.  So get_fbmem_region
> can go there, too.

NAK.
