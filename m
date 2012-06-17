From: davem@davemloft.net (David Miller)
Date: Sun, 17 Jun 2012 16:28:52 -0700 (PDT)
Subject: [PATCH net-next] net: lpc_eth: free skbs in start_xmit
In-Reply-To: <1339581496.22704.346.camel@edumazet-glaptop>
References: <1339568172.22704.312.camel@edumazet-glaptop>
 <4FD85D27.5090509@antcom.de>
 <1339581496.22704.346.camel@edumazet-glaptop>
Message-ID: <20120617.162852.2208481357025267726.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 13 Jun 2012 11:58:16 +0200

> From: Eric Dumazet <edumazet@google.com>
> 
> Transmitted skbs can be freed immediately in lpc_eth_hard_start_xmit()
> instead of at TX completion, since driver copies the frames in DMA area.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Roland Stigge <stigge@antcom.de>

Applied.
