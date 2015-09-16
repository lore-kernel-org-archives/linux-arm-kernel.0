From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 19:13:40 +0800
Subject: [RFC PATCH v3 2/3] ia64: rename migrate_irqs() to avoid compiling
 error
In-Reply-To: <alpine.DEB.2.11.1509161020120.3951@nanos>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
 <1442375907-11496-3-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1509161020120.3951@nanos>
Message-ID: <55F94EE4.50104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/16 16:21, Thomas Gleixner wrote:
> On Wed, 16 Sep 2015, Yang Yingliang wrote:
>
>> To avoid multi-declaration error after adding migrate_irqs into
>> kernel/irq/migration.c, rename migrate_irqs() to move_irqs().
>
> And why can't you chose a different name for the generic function
> instead of creating useless churn in IA64?

I am not sure which way is better at first. Never mind, I will chose a 
new name for the generic function.

Thanks,
Yang
>
> Thanks,
>
> 	tglx
>
> .
>
