From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 19:49:04 +0100
Subject: [RFC PATCH v5 1/4] genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION
In-Reply-To: <1442631959-10228-2-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
 <1442631959-10228-2-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150922194904.613cfc15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2015 11:05:56 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Introduce a more general config for compile kernel/irq/migration.c.
> Move the CONFIG_GENERIC_PENDING_IRQ into migration.c. So we can
> move other migration interrupts code into migration.c without
> select CONFIG_GENERIC_PENDING_IRQ.
> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
