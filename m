From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 10:31:07 +0000
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110126091103.GE1147@pengutronix.de>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110126084613.GD1147@pengutronix.de>
	<20110126085240.GA2698@n2100.arm.linux.org.uk>
	<20110126091103.GE1147@pengutronix.de>
Message-ID: <20110126103107.GA4232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 10:11:03AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Jan 26, 2011 at 08:52:40AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K?nig wrote:
> > > Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?
> > 
> > Does mx stuff do non-irq setup or non-map_io stuff in those callbacks?
> the map_io callbacks (e.g. mx27_map_io) setup the infrastructure for
> cpu_is_xyz and arch_reset.

In which case yes please.
