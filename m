From: davem@davemloft.net (David Miller)
Date: Sun, 24 Mar 2013 17:17:38 -0400 (EDT)
Subject: [PATCH net-next] dsa: add device tree bindings to register DSA
 switches
In-Reply-To: <2044972.NvctqPqDPo@bender>
References: <2044972.NvctqPqDPo@bender>
Message-ID: <20130324.171738.301089541347666424.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <florian@openwrt.org>
Date: Fri, 22 Mar 2013 21:50:50 +0100

> This patch adds support for registering DSA switches using Device Tree
> bindings. Note that we support programming the switch routing table even
> though no in-tree user seems to require it. I tested this on Armada 370
> with a Marvell 88E6172 (not supported by mainline yet).
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Applied.
