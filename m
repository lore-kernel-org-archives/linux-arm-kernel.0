From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Jan 2011 10:11:03 +0100
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110126085240.GA2698@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110126084613.GD1147@pengutronix.de>
	<20110126085240.GA2698@n2100.arm.linux.org.uk>
Message-ID: <20110126091103.GE1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 08:52:40AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K?nig wrote:
> > Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?
> 
> Does mx stuff do non-irq setup or non-map_io stuff in those callbacks?
the map_io callbacks (e.g. mx27_map_io) setup the infrastructure for
cpu_is_xyz and arch_reset.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
