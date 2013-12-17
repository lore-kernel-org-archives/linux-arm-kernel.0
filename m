From: davem@davemloft.net (David Miller)
Date: Tue, 17 Dec 2013 14:43:13 -0500 (EST)
Subject: [PATCH v2 0/5] net: phy: Ethernet PHY powerdown optimization
In-Reply-To: <1386926429-28818-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386926429-28818-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131217.144313.1563516273987934449.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Fri, 13 Dec 2013 10:20:24 +0100

> This is v2 of the ethernet PHY power optimization patches to reduce
> power consumption of network PHYs with link that are either unused or
> the corresponding netdev is down.
> 
> Compared to the last version, this patch set drops a patch to disable
> unused PHYs after late initcall, as it is not compatible with a modular
> mdio bus [1]. I'll investigate different ways to have a modular mdio bus
> driver get notified when driver loading is done.
> 
> Again, a branch with v2 applied to v3.13-rc2 can also be found at
> https://github.com/shesselba/linux-dove.git topic/ethphy-power-v2
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg293028.html

Series applied, thanks.
