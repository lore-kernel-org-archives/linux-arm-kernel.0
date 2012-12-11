From: davem@davemloft.net (David Miller)
Date: Tue, 11 Dec 2012 13:57:59 -0500 (EST)
Subject: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
In-Reply-To: <1355252096.27891.130.camel@edumazet-glaptop>
References: <20121211.133058.2238010228178961245.davem@davemloft.net>
 <20121211.133426.484976995112519196.davem@davemloft.net>
 <1355252096.27891.130.camel@edumazet-glaptop>
Message-ID: <20121211.135759.1010213285970148974.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <erdnetdev@gmail.com>
Date: Tue, 11 Dec 2012 10:54:56 -0800

> Suggested fix : add a TCQ_F_MQSLAVE flag to allow dequeue_skb() to test
> the netif_xmit_frozen_or_stopped() status _before_ dequeing packet from
> qdisc.

This sounds fine to me.
