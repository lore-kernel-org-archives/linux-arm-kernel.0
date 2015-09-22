From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 19:48:27 +0100
Subject: [RFC PATCH v5 2/4] genirq: add irq_migrate_all_off_this_cpu()
 for cpu hotplug
In-Reply-To: <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
 <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150922194827.6c7deee4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2015 11:05:57 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Add irq_migrate_all_off_this_cpu() into kernel/irq/migration.c.
> So we can use it to migrate interrupts, when cpu is offline.
> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
