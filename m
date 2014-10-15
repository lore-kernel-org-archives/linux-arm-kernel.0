From: davem@davemloft.net (David Miller)
Date: Tue, 14 Oct 2014 22:36:41 -0400 (EDT)
Subject: [PATCH v3 25/27] Sparc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
In-Reply-To: <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
Message-ID: <20141014.223641.1750858832286185881.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 11:07:13 +0800

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
