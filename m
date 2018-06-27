From: davem@davemloft.net (David Miller)
Date: Wed, 27 Jun 2018 18:17:23 +0900 (KST)
Subject: [PATCH v3] net: ethernet: stmmac: dwmac-rk: Add GMAC support
 for px30
In-Reply-To: <1530001173-21935-1-git-send-email-david.wu@rock-chips.com>
References: <1530001173-21935-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20180627.181723.1142068438004890978.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>
Date: Tue, 26 Jun 2018 16:19:33 +0800

> Add constants and callback functions for the dwmac on px30 Soc.
> The base structure is the same, but registers and the bits in
> them are moved slightly, and add the clk_mac_speed for selecting
> mac speed.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

This patch doesn't apply to net-next.
