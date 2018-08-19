From: davem@davemloft.net (David Miller)
Date: Sun, 19 Aug 2018 10:49:44 -0700 (PDT)
Subject: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada 3700
In-Reply-To: <20180810222335.GD11955@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
 <20180810.144031.861564620036768413.davem@davemloft.net>
 <20180810222335.GD11955@lunn.ch>
Message-ID: <20180819.104944.1717508823921470560.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Aug 2018 00:23:35 +0200

> Please can you queue up:
> 
> Fixes: 7a86f05faf11 ("net: ethernet: mvneta: Fix napi structure mixup on armada 3700")
> 
> and this patch for stable.

Since these are now both in Linus's tree, done.

But, if one thinks the change belongs in -stable, target 'net' always.
