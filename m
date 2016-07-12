From: davem@davemloft.net (David Miller)
Date: Tue, 12 Jul 2016 11:08:18 -0700 (PDT)
Subject: [PATCH -next] net: mediatek: fix non static symbol warnings
In-Reply-To: <1468323404-2193-1-git-send-email-weiyj_lk@163.com>
References: <1468323404-2193-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160712.110818.2218245588469646537.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: weiyj_lk@163.com
Date: Tue, 12 Jul 2016 11:36:44 +0000

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warnings:
> 
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:79:5: warning:
>  symbol '_mtk_mdio_write' was not declared. Should it be static?
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:98:5: warning:
>  symbol '_mtk_mdio_read' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
