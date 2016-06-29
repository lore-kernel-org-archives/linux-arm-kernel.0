From: davem@davemloft.net (David Miller)
Date: Wed, 29 Jun 2016 08:19:03 -0400 (EDT)
Subject: [PATCH 2/2] net: ethernet: lpc_eth: use
 phy_ethtool_{get|set}_link_ksettings
In-Reply-To: <1467151185-31403-2-git-send-email-tremyfr@gmail.com>
References: <1467151185-31403-1-git-send-email-tremyfr@gmail.com>
 <1467151185-31403-2-git-send-email-tremyfr@gmail.com>
Message-ID: <20160629.081903.1209115201246381107.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Tue, 28 Jun 2016 23:59:45 +0200

> There are two generics functions phy_ethtool_{get|set}_link_ksettings,
> so we can use them instead of defining the same code in the driver.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
