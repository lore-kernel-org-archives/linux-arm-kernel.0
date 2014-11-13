From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 13 Nov 2014 09:04:52 +0800
Subject: [PATCH] net: pxa168_eth: move SET_NETDEV_DEV a bit earlier
In-Reply-To: <20141112.150810.806933062338696000.davem@davemloft.net>
References: <1415790527-6494-1-git-send-email-jszhang@marvell.com>
 <20141112.150810.806933062338696000.davem@davemloft.net>
Message-ID: <20141113090452.635b4fa0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David,

On Wed, 12 Nov 2014 12:08:10 -0800
David Miller <davem@davemloft.net> wrote:

> From: Jisheng Zhang <jszhang@marvell.com>
> Date: Wed, 12 Nov 2014 19:08:47 +0800
> 
> > This is to ensure the net_device's dev.parent is set before we used it
> > in dma_zalloc_coherent() from init_hash_table().
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> 
> Please always be explicit about what tree you generated this patch against
> and therefore expect it to be applied to by saying "[PATCH net-next]" or
> similar in your Subject line.

Got it. I will take care next time.

Thanks a lot
