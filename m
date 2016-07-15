From: davem@davemloft.net (David Miller)
Date: Thu, 14 Jul 2016 17:43:06 -0700 (PDT)
Subject: [PATCH 2/2] net: ethernet: ll_temac: use
 phy_ethtool_{get|set}_link_ksettings
In-Reply-To: <1468453732-7370-2-git-send-email-tremyfr@gmail.com>
References: <1468453732-7370-1-git-send-email-tremyfr@gmail.com>
 <1468453732-7370-2-git-send-email-tremyfr@gmail.com>
Message-ID: <20160714.174306.915953817280918268.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Thu, 14 Jul 2016 01:48:52 +0200

> There are two generics functions phy_ethtool_{get|set}_link_ksettings,
> so we can use them instead of defining the same code in the driver.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
