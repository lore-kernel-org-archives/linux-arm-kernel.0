From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Apr 2014 20:35:49 +0100
Subject: [PATCH] arm: allow all architectures to change max zone order
In-Reply-To: <1397487962.4548.30.camel@weser.hi.pengutronix.de>
References: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
 <1397487962.4548.30.camel@weser.hi.pengutronix.de>
Message-ID: <20140414193549.GJ24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 05:06:02PM +0200, Lucas Stach wrote:
> Russell, can you please take a look at this? Nobody else seems to care
> about this and we have to carry it around as without it imx-drm is
> broken for FullHD displays with a 32bpp framebuffer.

I intentionally decided to ignore it because of the argumentative
description in it that implies that I'm stupid for not making this
available everywhere.  So, it can wait a bit longer.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
