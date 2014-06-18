From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 18 Jun 2014 22:08:03 +0800
Subject: [PATCH 1/2] ARM: dts: hummingboard: add support for BT/wifi
 where fitted
In-Reply-To: <20140618134459.GD32514@n2100.arm.linux.org.uk>
References: <E1WufIK-0007yl-2k@rmk-PC.arm.linux.org.uk>
 <20140618133345.GL8860@dragon>
 <20140618134459.GD32514@n2100.arm.linux.org.uk>
Message-ID: <20140618140802.GM8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 02:44:59PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 18, 2014 at 09:33:46PM +0800, Shawn Guo wrote:
> > On Wed, Jun 11, 2014 at 10:58:12AM +0100, Russell King wrote:
> > > Some microsom modules have BT/Wifi fitted for the Hummingboard.  Enable
> > > support for this additional hardware; where it isn't present, the SDIO
> > > BT/Wifi will not be detected, and no harm will come from having these
> > > additional devices enabled.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Applied this one, thanks.
> 
> Probably not a good idea - which is why I didn't re-send it with my

Okay, dropped.

Shawn
