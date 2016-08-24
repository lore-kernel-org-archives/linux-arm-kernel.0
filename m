From: davem@davemloft.net (David Miller)
Date: Tue, 23 Aug 2016 17:18:38 -0700 (PDT)
Subject: [PATCH -next] net: phy: xgmiitorgmii: Fix non static symbol
 warning
In-Reply-To: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
References: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160823.171838.386599136081866354.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Tue, 23 Aug 2016 15:06:05 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/net/phy/xilinx_gmii2rgmii.c:61:5: warning:
>  symbol 'xgmiitorgmii_probe' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
