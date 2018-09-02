From: davem@davemloft.net (David Miller)
Date: Sun, 02 Sep 2018 14:14:03 -0700 (PDT)
Subject: [PATCH net-next v2 0/3] net: mvneta: some small improvements
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
Message-ID: <20180902.141403.1656418595490448023.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Fri, 31 Aug 2018 16:08:10 +0800

> patch1 removes the NETIF_F_GRO check ourself, because the net subsystem
> will handle it for us.
> 
> patch2 enables NETIF_F_RXCSUM by default, since the driver and HW
> supports the feature.
> 
> patch3 is a small optimization, to reduce smp_processor_id() calling
> in mvneta_tx_done_gbe.
> 
> since v1:
>  - based on net-next tree
>  - remove the fix patches, since they should be based on net branch.
>  - Add Gregory's Reviewed-by tag

Series applied, thanks.
