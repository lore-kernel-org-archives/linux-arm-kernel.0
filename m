From: davem@davemloft.net (David Miller)
Date: Tue, 26 Apr 2016 01:11:16 -0400 (EDT)
Subject: [PATCH v2 net-next 00/13] net: hns: add support of debug dsaf
 device
In-Reply-To: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <20160426.011116.1045874009330763236.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yisen Zhuang <Yisen.Zhuang@huawei.com>
Date: Sat, 23 Apr 2016 17:05:04 +0800

> There are two kinds of dsaf device in hns, one is for service ports,
> contains crossbar in it, can work under different mode. Another is for
> debug port, only can work under single port mode. The current code only
> declares a dsaf device for both service ports and debug ports.It is not so
> readability. This patch separates it to three platform devices to make the
> code more simple and readability.
 ...
> We take the compatibility into consideration, and it works well by using the
> old dts file(tested on d02 board).
> 
> For more details, please see individual patches.

Series applied, thanks.
