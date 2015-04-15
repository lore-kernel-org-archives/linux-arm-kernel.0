From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 16:11:23 +0200
Subject: [PATCH net-next 1/6] net: hip04: Set more appropriate value for
 tx coalesce num
In-Reply-To: <1429101008-9464-2-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
 <1429101008-9464-2-git-send-email-dingtianhong@huawei.com>
Message-ID: <4574922.qP9qWKPK3R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 20:30:03 Ding Tianhong wrote:
> According Arnd's suggestion, the user might set the tx coalesce value
> in large range for different workloads, so we should define them to
> appropriate value.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Joe Perches <joe@perches.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
