From: davem@davemloft.net (David Miller)
Date: Mon, 28 Mar 2016 11:39:43 -0400 (EDT)
Subject: [PATCH net-next 2/2] net: hns: set-coalesce-usecs returns
 errno by dsaf.ko
In-Reply-To: <1459161657-151406-3-git-send-email-Yisen.Zhuang@huawei.com>
References: <1459161657-151406-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1459161657-151406-3-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <20160328.113943.1432536731823075776.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yisen Zhuang <Yisen.Zhuang@huawei.com>
Date: Mon, 28 Mar 2016 18:40:57 +0800

> From: Lisheng <lisheng011@huawei.com>
> 
> It may fail to set coalesce usecs to HW, and Ethtool needs to know if it
> is successful to cfg the parameter or not. So it needs return the errno by
> dsaf.ko.
> 
> Signed-off-by: Lisheng <lisheng011@huawei.com>
> Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>

Applied.
