From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Sep 2015 10:21:08 +0200 (CEST)
Subject: [RFC PATCH v3 2/3] ia64: rename migrate_irqs() to avoid compiling
 error
In-Reply-To: <1442375907-11496-3-git-send-email-yangyingliang@huawei.com>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
 <1442375907-11496-3-git-send-email-yangyingliang@huawei.com>
Message-ID: <alpine.DEB.2.11.1509161020120.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015, Yang Yingliang wrote:

> To avoid multi-declaration error after adding migrate_irqs into
> kernel/irq/migration.c, rename migrate_irqs() to move_irqs().

And why can't you chose a different name for the generic function
instead of creating useless churn in IA64?
 
Thanks,

	tglx
