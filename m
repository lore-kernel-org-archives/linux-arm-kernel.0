From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Nov 2017 13:18:13 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <20171126122530.857-1-peng.fan@nxp.com>
References: <20171126122530.857-1-peng.fan@nxp.com>
Message-ID: <20171126131812.GZ31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> To boot Linux in Non-secure mode with l2x0, the l2x0 controller
> is enabled in secure mode and ways locked to make it seems L2 cache
> disabled during linux boot process. So during l2x0 initialization,
> need to unlock the ways to make l2x0 could cache data/inst.

Why was this chosen instead of doing what everyone else does?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
