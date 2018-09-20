From: davem@davemloft.net (David Miller)
Date: Wed, 19 Sep 2018 21:19:10 -0700 (PDT)
Subject: [PATCH net-next] net: xilinx: fix return type of
 ndo_start_xmit function
In-Reply-To: <20180919103240.27708-2-yuehaibing@huawei.com>
References: <20180919103240.27708-1-yuehaibing@huawei.com>
 <20180919103240.27708-2-yuehaibing@huawei.com>
Message-ID: <20180919.211910.1797000547538135051.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 19 Sep 2018 18:32:40 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
