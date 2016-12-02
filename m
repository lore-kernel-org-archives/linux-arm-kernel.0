From: davem@davemloft.net (David Miller)
Date: Fri, 02 Dec 2016 13:52:27 -0500 (EST)
Subject: [PATCH v6 net-next 0/7] Support Armada 37xx SoC (ARMv8
 64-bits) in mvneta driver
In-Reply-To: <cover.dd374b7aaa358be0211d7ead81129a399fa692f4.1480611779.git-series.gregory.clement@free-electrons.com>
References: <cover.dd374b7aaa358be0211d7ead81129a399fa692f4.1480611779.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161202.135227.1138440285760115646.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Thu,  1 Dec 2016 18:03:03 +0100

> The Armada 37xx is a new ARMv8 SoC from Marvell using same network
> controller as the older Armada 370/38x/XP SoCs. This series adapts the
> driver in order to be able to use it on this new SoC. The main changes
> are:
> 
> - 64-bits support: the first patches allow using the driver on a 64-bit
>   architecture.
> 
> - MBUS support: the mbus configuration is different on Armada 37xx
>   from the older SoCs.
> 
> - per cpu interrupt: Armada 37xx do not support per cpu interrupt for
>   the NETA IP, the non-per-CPU behavior was added back.
> 
> The first patch is an optimization in the rx path in swbm mode.
> The second patch remove unnecessary allocation for HWBM.
> The first item is solved by patches 4 and 5.
> The 2 last items are solved by patch 6.
> In patch 7 the dt support is added.
> 
> Beside Armada 37xx, this series have been again tested on Armada XP
> and Armada 38x (with Hardware Buffer Management and with Software
> Buffer Management).
 ...

Series applied, thanks.
