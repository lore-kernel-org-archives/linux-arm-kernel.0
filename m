From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 12 Dec 2012 19:08:16 +0530
Subject: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
In-Reply-To: <20121211.135759.1010213285970148974.davem@davemloft.net>
References: <20121211.133058.2238010228178961245.davem@davemloft.net>
 <20121211.133426.484976995112519196.davem@davemloft.net>
 <1355252096.27891.130.camel@edumazet-glaptop>
 <20121211.135759.1010213285970148974.davem@davemloft.net>
Message-ID: <50C888C8.3070708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 12:27 AM, David Miller wrote:
> From: Eric Dumazet <erdnetdev@gmail.com>
> Date: Tue, 11 Dec 2012 10:54:56 -0800
>
>> Suggested fix : add a TCQ_F_MQSLAVE flag to allow dequeue_skb() to test
>> the netif_xmit_frozen_or_stopped() status _before_ dequeing packet from
>> qdisc.
> This sounds fine to me.
I will submit next version with the suggestion

Regards
Mugunthan V N
