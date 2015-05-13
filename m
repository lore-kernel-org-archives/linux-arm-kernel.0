From: davem@davemloft.net (David Miller)
Date: Tue, 12 May 2015 23:18:14 -0400 (EDT)
Subject: [PATCH v2] net: ll_temac: Fix DMA map size bug
In-Reply-To: <66b8efd7a63674220d55a03d0220897bd8b8712b.1431410769.git.michal.simek@xilinx.com>
References: <66b8efd7a63674220d55a03d0220897bd8b8712b.1431410769.git.michal.simek@xilinx.com>
Message-ID: <20150512.231814.973421258533609463.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Tue, 12 May 2015 08:06:15 +0200

> DMA allocates skb->len instead of headlen
> which is used for DMA.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied, thank you.
