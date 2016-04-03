From: davem@davemloft.net (David Miller)
Date: Sat, 02 Apr 2016 20:17:25 -0400 (EDT)
Subject: [PATCH v2 net-next] net: hns: add support of pause frame ctrl
 for HNS V2
In-Reply-To: <1459429209-230671-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1459429209-230671-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <20160402.201725.1897910785412352542.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yisen Zhuang <Yisen.Zhuang@huawei.com>
Date: Thu, 31 Mar 2016 21:00:09 +0800

> From: Lisheng <lisheng011@huawei.com>
> 
> The patch adds support of pause ctrl for HNS V2, and this feature is lost
> by HNS V1:
>        1) service ports can disable rx pause frame,
>        2) debug ports can open tx/rx pause frame.
> 
> And this patch updates the REGs about the pause ctrl when updated
> status function called by upper layer routine.
> 
> Signed-off-by: Lisheng <lisheng011@huawei.com>
> Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.
