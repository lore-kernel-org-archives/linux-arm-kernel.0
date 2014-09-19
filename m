From: davem@davemloft.net (David Miller)
Date: Fri, 19 Sep 2014 15:37:58 -0400 (EDT)
Subject: [Patch net-next v3 0/4] net: fec: add interrupt coalescence
In-Reply-To: <1410902334-7827-1-git-send-email-Frank.Li@freescale.com>
References: <1410902334-7827-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140919.153758.2070105844475669082.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <Frank.Li@freescale.com>
Date: Wed, 17 Sep 2014 05:18:50 +0800

> From: Frank Li <Frank.Li@freescale.com>
> improve error handle when parse queue number.
> add interrupt coalescence feature.
> 
> Change from v2 to v3
>  - add error check in fec_enet_set_coalesce
>  - fix a run time warning to get clock rate in interrupt
>  - fix commit message use TKT number
> 
> Change from v1 to v2
>  - fix indention
>  - use errata number instead of TKT

Series applied, thanks Frank.
