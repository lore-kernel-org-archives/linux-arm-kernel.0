From: davem@davemloft.net (David Miller)
Date: Mon, 28 Sep 2015 22:34:50 -0700 (PDT)
Subject: [PATCH net-next v4] net: Fix Hisilicon Network Subsystem
 Support Compilation
In-Reply-To: <1443338564-185286-1-git-send-email-huangdaode@hisilicon.com>
References: <1443338564-185286-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <20150928.223450.2253763281253460708.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: huangdaode <huangdaode@hisilicon.com>
Date: Sun, 27 Sep 2015 15:22:44 +0800

> This patch fixes the compilation error with arm allmodconfig, this error
> generated due to unavailability of readq() on 32-bit platform which was
> found during net-next daily compilation. In the same time, fix all the
> hns drivers compilation warnings.
> 
> Signed-off-by: huangdaode <huangdaode@hisilicon.com>
> Signed-off-by: zhaungyuzeng <Yisen.zhuang@huawei.com>
> Signed-off-by: kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: yankejian <yankejian@huawei.com>

Applied, thanks.
