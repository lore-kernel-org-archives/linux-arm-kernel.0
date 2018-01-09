From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jan 2018 14:42:38 +0000
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109085945.11916-5-antoine.tenart@free-electrons.com>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
Message-ID: <20180109144238.GH17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
> driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
> nearly the same code path.

For 2500Base-X, do you report a speed of 2500Mbps through ethtool, or
are you reporting 1000Mbps?  I don't see any code in this patch that
deals with that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
