From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 16:20:35 +0200
Subject: [PATCH net-next 6/6] net: hip04: add ratelimit for rx/tx drops skb
In-Reply-To: <1429101008-9464-7-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
 <1429101008-9464-7-git-send-email-dingtianhong@huawei.com>
Message-ID: <2240101.PVIEOFjhsq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 20:30:08 Ding Tianhong wrote:
> There can be quite a lot of rx/tx drops message and affect
> useful message, so need to ratelimit them to not overwhelm
> logging.
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
