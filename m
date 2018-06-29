From: davem@davemloft.net (David Miller)
Date: Fri, 29 Jun 2018 22:19:25 +0900 (KST)
Subject: [PATCH v4] net: ethernet: stmmac: dwmac-rk: Add GMAC support
 for px30
In-Reply-To: <1530149601-23337-1-git-send-email-david.wu@rock-chips.com>
References: <1530149601-23337-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20180629.221925.1974171391493646561.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>
Date: Thu, 28 Jun 2018 09:33:21 +0800

> Add constants and callback functions for the dwmac on px30 Soc.
> The base structure is the same, but registers and the bits in
> them are moved slightly, and add the clk_mac_speed for selecting
> mac speed.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Applied.
