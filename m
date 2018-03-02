From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 22:02:15 +0000
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <20180302215614.GD25189@lunn.ch>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
 <20180302215614.GD25189@lunn.ch>
Message-ID: <20180302220215.GC9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 10:56:14PM +0100, Andrew Lunn wrote:
> On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> > Add SFP module support for Clearfog using the SFP phylink support.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Using a RoboFiber SFP module, connected to a media converter. Link
> up/down detected.

ethtool -m should also work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
