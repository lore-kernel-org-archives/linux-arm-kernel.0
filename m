From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Mar 2018 12:49:06 +0000
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <20180304121324.ut3d3i2vpdopae7o@sapphire.tkos.co.il>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
 <20180304121324.ut3d3i2vpdopae7o@sapphire.tkos.co.il>
Message-ID: <20180304124905.GF9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 02:13:24PM +0200, Baruch Siach wrote:
> Hi Russell,
> 
> On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> > Add SFP module support for Clearfog using the SFP phylink support.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Tested-by: Baruch Siach <baruch@tkos.co.il>
> 
> Tested on Clearfog base with kernel version 4.16-rc3. The SFP module is 1G 
> copper Linktel LX1801CNR.

Thanks for testing.

Please also send the "ethtool -m eth2 raw on > foo.bin" output as well
so I can build a database of module EEPROMs, which allows me to validate
the SFP parsing code against.  Alternatively, please send the "hex on"
if you think that's more convenient.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
