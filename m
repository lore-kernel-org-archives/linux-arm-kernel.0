From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 08:52:40 +0000
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110126084613.GD1147@pengutronix.de>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110126084613.GD1147@pengutronix.de>
Message-ID: <20110126085240.GA2698@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K?nig wrote:
> Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?

Does mx stuff do non-irq setup or non-map_io stuff in those callbacks?
