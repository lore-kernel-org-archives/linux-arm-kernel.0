From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 14:44:59 +0100
Subject: [PATCH 1/2] ARM: dts: hummingboard: add support for BT/wifi
 where fitted
In-Reply-To: <20140618133345.GL8860@dragon>
References: <E1WufIK-0007yl-2k@rmk-PC.arm.linux.org.uk>
 <20140618133345.GL8860@dragon>
Message-ID: <20140618134459.GD32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:33:46PM +0800, Shawn Guo wrote:
> On Wed, Jun 11, 2014 at 10:58:12AM +0100, Russell King wrote:
> > Some microsom modules have BT/Wifi fitted for the Hummingboard.  Enable
> > support for this additional hardware; where it isn't present, the SDIO
> > BT/Wifi will not be detected, and no harm will come from having these
> > additional devices enabled.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Applied this one, thanks.

Probably not a good idea - which is why I didn't re-send it with my
recent set.  As we /still/ don't have the story sorted six months down
the line for handling the power and reset signals for the module, we
still don't know what the final bindings are going to look like.

I've more or less given up any hope of that situation being resolved;
I'm intending to maintain Olof's patches locally, publishing them for
Cubox-i users.  At this point, I really couldn't care less what the
dysfunctional mainline kernel community does in respect of this very
necessary feature.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
