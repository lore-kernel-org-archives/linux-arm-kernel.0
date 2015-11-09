From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 17:33:17 +0000
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <20151109170849.GC3388@lunn.ch>
References: <4225885.EYXTHjRPmX@wuerfel> <20151109164232.GB3388@lunn.ch>
 <6910088.dNmooXDTJR@wuerfel> <20151109170849.GC3388@lunn.ch>
Message-ID: <20151109173316.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 06:08:49PM +0100, Andrew Lunn wrote:
> You use fixed-phy when the MAC is connected to a switch, not a phy. Or
> when the MAC is connected to an SFP module.

... hopefully not for much longer.  Once -rc1 is out, I'll sort out
posting my phylink and SFP module hotplug support as a RFC.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
