From: davem@davemloft.net (David Miller)
Date: Wed, 22 Jun 2016 16:25:52 -0400 (EDT)
Subject: [PATCH 2/2] net: ethernet: sun4i-emac: use
 phy_ethtool_{get|set}_link_ksettings
In-Reply-To: <1466255740-20999-2-git-send-email-tremyfr@gmail.com>
References: <1466255740-20999-1-git-send-email-tremyfr@gmail.com>
 <1466255740-20999-2-git-send-email-tremyfr@gmail.com>
Message-ID: <20160622.162552.1263761804213726339.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sat, 18 Jun 2016 15:15:40 +0200

> There are two generics functions phy_ethtool_{get|set}_link_ksettings,
> so we can use them instead of defining the same code in the driver.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
