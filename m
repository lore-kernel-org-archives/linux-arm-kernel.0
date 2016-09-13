From: davem@davemloft.net (David Miller)
Date: Tue, 13 Sep 2016 11:43:02 -0400 (EDT)
Subject: [PATCH -next] net: ethernet: dwmac: fix non static symbol warning
In-Reply-To: <1473510690-25198-1-git-send-email-weiyj.lk@gmail.com>
References: <1473510690-25198-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160913.114302.647506594831247002.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 10 Sep 2016 12:31:30 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c:172:1: warning:
>  symbol 'stm32_dwmac_pm_ops' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
