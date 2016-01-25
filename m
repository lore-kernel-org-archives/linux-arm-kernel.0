From: davem@davemloft.net (David Miller)
Date: Sun, 24 Jan 2016 22:16:18 -0800 (PST)
Subject: [PATCH] drivers: net: xgene: fix extra IRQ issue
In-Reply-To: <1453421261-4295-1-git-send-email-isubramanian@apm.com>
References: <1453421261-4295-1-git-send-email-isubramanian@apm.com>
Message-ID: <20160124.221618.1619209434096345332.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Thu, 21 Jan 2016 16:07:41 -0800

> For interrupt controller that doesn't support irq_disable and hardware
> with level interrupt, an extra interrupt may be pending. This patch fixes
> the issue by setting IRQ_DISABLE_UNLAZY flag for the interrupt line,
> as suggested by,
> 
> 'commit e9849777d0e2 ("genirq: Add flag to force mask in
> 		       disable_irq[_nosync]()")'
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Toan Le <toanle@apm.com>

Applied, thanks.
