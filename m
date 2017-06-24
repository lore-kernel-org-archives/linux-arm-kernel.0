From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 24 Jun 2017 18:05:35 +0200
Subject: [PATCH 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <20170624140406.GL4875@lunn.ch>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <2277908.rG2NXdikOp@phil> <20170624140406.GL4875@lunn.ch>
Message-ID: <8013275.fit4cPZyaE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 24. Juni 2017, 16:04:06 CEST schrieb Andrew Lunn:
> > hmm, we do have quite a number of non-net phys in the phy subsystem
> > (DP, PCIe, ...) and given that the above would be CONFIG_ROCKCHIP_PHY
> > in a global sense, sounds like it could make things confusing.
> > 
> > So some addition sounds reasonable ... ROCKCHIP_ETH_PHY or so?
> 
> I follow you reasoning, but generic phy is the new kid on the
> block. It is well established that Ethernet PHYs are called
> <MANUFACTURER>_PHY.

Ok, then without further bikeshedding, let's just go with your
naming then (ROCKCHIP_PHY) :-) .


Heiko

> If you do want to consider generic phy, the logical name would be
> ROCKCHIP_PHY_PHY, since generic phy postfixes with _SATA, _USB, _PCIE,
> etc. But that does leave an issues when we have an Ethernet PHY which
> needs a generic PHY. In some sense, SERDES could be considered as
> something supported by a generic PHY...
> 
> 	Andrew
> 
> 
