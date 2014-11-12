From: davem@davemloft.net (David Miller)
Date: Wed, 12 Nov 2014 15:08:10 -0500 (EST)
Subject: [PATCH] net: pxa168_eth: move SET_NETDEV_DEV a bit earlier
In-Reply-To: <1415790527-6494-1-git-send-email-jszhang@marvell.com>
References: <1415790527-6494-1-git-send-email-jszhang@marvell.com>
Message-ID: <20141112.150810.806933062338696000.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Wed, 12 Nov 2014 19:08:47 +0800

> This is to ensure the net_device's dev.parent is set before we used it
> in dma_zalloc_coherent() from init_hash_table().
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Please always be explicit about what tree you generated this patch against
and therefore expect it to be applied to by saying "[PATCH net-next]" or
similar in your Subject line.

Because this only applies cleanly to net-next, that's where I installed
it.

Thanks.
