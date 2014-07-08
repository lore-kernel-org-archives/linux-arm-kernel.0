From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jul 2014 12:47:18 +0100
Subject: [PATCH CFT 02/30] net: fec: iMX6 FEC does not support
 half-duplex gigabit
In-Reply-To: <20140708064611.GF7827@pengutronix.de>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
 <E1X0Xvb-0001Mu-JB@rmk-PC.arm.linux.org.uk>
 <20140708064611.GF7827@pengutronix.de>
Message-ID: <20140708114718.GI21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 08:46:11AM +0200, Uwe Kleine-K?nig wrote:
> Hi Russell,
> 
> On Fri, Jun 27, 2014 at 04:19:03PM +0100, Russell King wrote:
> > The iMX6 gigabit FEC does not support half-duplex gigabit operation.
> > Phys attacked to the FEC may support this, and we currently do nothing
> Even if it might be interpreted as an attack to connect such a phy to
> the FEC, I'd still call it "attach" here :-)

You are right, but unfortunately your comment comes too late; this is
the actual submission for David to integrate the patches into net-next
rather than for review, and David has already integrated the change into
his tree.  Hence, the comment is unable to be fixed now.

Thanks anyway.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
