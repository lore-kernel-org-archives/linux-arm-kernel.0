From: davem@davemloft.net (David Miller)
Date: Fri, 12 Sep 2014 16:40:47 -0400 (EDT)
Subject: [Patch v3 net-next 09/12] net: fec: change FEC alignment
 according to i.mx6 sx requirement
In-Reply-To: <1410373845-5801-10-git-send-email-Frank.Li@freescale.com>
References: <1410373845-5801-1-git-send-email-Frank.Li@freescale.com>
 <1410373845-5801-10-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140912.164047.810313458974612565.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 11 Sep 2014 02:30:42 +0800

> +
> +	unsigned tx_align;
> +	unsigned rx_align;
>  };

Please always fully write out "unsigned int" rather than just "unsigned".

> @@ -2399,6 +2393,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	struct sk_buff *skb;
>  	struct bufdesc	*bdp;
>  	struct fec_enet_priv_rx_q *rxq;
> +	unsigned off;

Likewise.
