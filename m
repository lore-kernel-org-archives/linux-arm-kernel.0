From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 15:46:16 -0800
Subject: [PATCH POST V2] ARM: dts: Add am57xx-beagle-x15
In-Reply-To: <545D1150.9000700@ti.com>
References: <1415382433-31772-1-git-send-email-nm@ti.com>
 <545D1150.9000700@ti.com>
Message-ID: <20141110234615.GF31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tom Rini <trini@ti.com> [141107 10:38]:
> On 11/07/2014 12:47 PM, Nishanth Menon wrote:
> > BeagleBoard-X15 is the next generation Open Source Hardware
> > BeagleBoard based on TI's AM5728 SoC featuring dual core 1.5GHz A15
> > processor. The platform features 2GB DDR3L (w/dual 32bit busses),
> > eSATA, 3 USB3.0 ports, integrated HDMI (1920x1080 at 60), separate LCD
> > port, video In port, 4GB eMMC, uSD, Analog audio in/out, dual 1G
> > Ethernet.
> > 
> > For more information, refer to:
> > BeagleBoard-X15 Wiki:
> > http://www.elinux.org/Beagleboard:BeagleBoard-X15
> > 
> > AM5728 is part of the Sitara product family whose additional details
> > will be available: http://www.ti.com/lsds/ti/arm/overview.page
> > 
> > Technical Reference Manual for AM5728 is public domain at:
> > http://www.ti.com/lit/spruhz6
> > 
> > Just add basic support for the moment, the following updates are needed:
> >   i)	Ethernet - depends on SoC dts fixes
> >   ii)	USB Client (USB2) - depends on GPIO extcon
> >   ii)	HDMI - additional driver fixes pending
> >   iii)	Audio - additional driver fixes pending
> > 
> > NOTE:
> > AM5728 Data Manual (SPRS915L - August 2014) section 4.1.1 states: "All
> > unused power supply balls must be supplied with the voltages specified
> > in the Section 5.2, Recommended Operating Conditions". This implies
> > that all unused voltage rails for AM5728 can never be switched off even
> > if the hardware blocks inside that voltage domain is unused. Switching
> > off these unused rails may result in stability issues on other domains
> > and increased leakage and power-on-hour impacts.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Reviewed-by: Tom Rini <trini@ti.com>

Applying into omap-for-v3.19/dt thanks.

Tony
