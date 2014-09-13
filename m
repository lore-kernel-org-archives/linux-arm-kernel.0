From: davem@davemloft.net (David Miller)
Date: Sat, 13 Sep 2014 17:32:53 -0400 (EDT)
Subject: [Patch v4 net-next 00/12] net: fec: imx6sx multiqueue support
In-Reply-To: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140913.173253.463259197219785898.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <Frank.Li@freescale.com>
Date: Sat, 13 Sep 2014 05:00:45 +0800

> From: Frank Li <Frank.Li@freescale.com>
> 
> These patches enable i.MX6SX multi queue support.
> i.MX6SX support 3 queue and AVB feature.
> 
> Change from v3 to v4
>  - use "unsigned int" instead of "unsigned"
> 
> Change from v2 to v3
>  - fixed alignment requirement for ARM and NO-ARM platform
> 
> Change from v1 to v2.
>  - Change num_tx_queue to unsigned int
>  - Avoid block non-dt platform
>  - remove call netif_set_real_num_rx_queues
>  - seperate multi queue patch two part, one is tx and rx handle, with fixed queue 0
>    then other one is initilized multiqueue
>  - use two difference alignment for tx and rx path

Series applied, thanks Frank.
