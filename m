From: davem@davemloft.net (David Miller)
Date: Sat, 09 Mar 2013 16:11:42 -0500 (EST)
Subject: [PATCH net-next] drivers:net: Remove unnecessary OOM messages
 after netdev_alloc_skb
In-Reply-To: <6379afbec3439c45180956b06c13b02ce3c9f802.1362790535.git.joe@perches.com>
References: <6379afbec3439c45180956b06c13b02ce3c9f802.1362790535.git.joe@perches.com>
Message-ID: <20130309.161142.153533460204187265.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Fri,  8 Mar 2013 17:03:25 -0800

> Emitting netdev_alloc_skb and netdev_alloc_skb_ip_align OOM
> messages is unnecessary as there is already a dump_stack
> after allocation failures.
> 
> Other trivial changes around these removals:
> 
> Convert a few comparisons of pointer to 0 to !pointer.
> Change flow to remove unnecessary label.
> Remove now unused variable.
> Hoist assignment from if.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
