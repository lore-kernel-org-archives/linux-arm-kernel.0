From: davem@davemloft.net (David Miller)
Date: Tue, 01 May 2018 11:30:22 -0400 (EDT)
Subject: [PATCH v2 0/2] net: stmmac: dwmac-meson: 100M phy mode support
 for AXG SoC
In-Reply-To: <20180428102111.18384-1-yixun.lan@amlogic.com>
References: <20180428102111.18384-1-yixun.lan@amlogic.com>
Message-ID: <20180501.113022.616723559128209395.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yixun Lan <yixun.lan@amlogic.com>
Date: Sat, 28 Apr 2018 10:21:09 +0000

> Due to the dwmac glue layer register changed, we need to 
> introduce a new compatible name for the Meson-AXG SoC
> to support for the RMII 100M ethernet PHY.
> 
> Change since v1 at [1]:
>   - implement set_phy_mode() for each SoC
> 
> [1] https://lkml.kernel.org/r/20180426160508.29380-1-yixun.lan at amlogic.com

Series applied, thank you.
