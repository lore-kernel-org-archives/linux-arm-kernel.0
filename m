From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 11 Apr 2013 10:35:25 -0700
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <20130411.133119.913809939413807690.davem@davemloft.net>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411.133119.913809939413807690.davem@davemloft.net>
Message-ID: <1365701725.3887.177.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-11 at 13:31 -0400, David Miller wrote:

> I think, as per other drivers, LRO should be eliminated completely from
> all drivers, including this one, and GRO used exclusively instead.

This would be awesome.

AFAIK current LRO users are :

drivers/infiniband/hw/nes/nes_hw.c
drivers/net/ethernet/marvell/mv643xx_eth.c
drivers/net/ethernet/pasemi/pasemi_mac.c
