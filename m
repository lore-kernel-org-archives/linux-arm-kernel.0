From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Mar 2017 12:26:10 +0000
Subject: [arm:clearfog 30/55] drivers/net/phy/phylink.c:141:11: error:
 too few arguments to function 'fwnode_get_named_gpiod'
In-Reply-To: <201703122040.bisMEQHh%fengguang.wu@intel.com>
References: <201703122040.bisMEQHh%fengguang.wu@intel.com>
Message-ID: <20170312122610.GK21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 08:23:45PM +0800, kbuild test robot wrote:
> Hi Russell,
> 
> First bad commit (maybe != root cause):

I've just fixed this - fwnode_get_named_gpiod() changed its prototype
between v4.10 and v4.11-rc1, and I've yet to finish fixing everything
up for the merge window changes.  This now takes me many hours spread
over many days to find and fix everything.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
