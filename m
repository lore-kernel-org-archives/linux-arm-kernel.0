From: wei.liu2@citrix.com (Wei Liu)
Date: Thu, 20 Sep 2018 15:05:49 +0100
Subject: [PATCH net-next 13/22] net: xen-netback: fix return type of
 ndo_start_xmit function
In-Reply-To: <20180920123306.14772-14-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-14-yuehaibing@huawei.com>
Message-ID: <20180920140549.xdowevpqjw45otjx@zion.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 08:32:57PM +0800, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>
