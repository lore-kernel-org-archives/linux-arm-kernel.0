From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 19:15:05 +0800
Subject: [RFC PATCH v3 3/3] arm/arm64: fix a migrating irq bug when
 hotplug cpu
In-Reply-To: <alpine.DEB.2.11.1509161013430.3951@nanos>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
 <1442375907-11496-4-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1509161013430.3951@nanos>
Message-ID: <55F94F39.7080504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/16 16:21, Thomas Gleixner wrote:
> On Wed, 16 Sep 2015, Yang Yingliang wrote:
>>   arch/arm/Kconfig             |  1 +
>>   arch/arm/include/asm/irq.h   |  1 -
>>   arch/arm/kernel/irq.c        | 62 -----------------------------------------
>>   arch/arm64/Kconfig           |  1 +
>>   arch/arm64/include/asm/irq.h |  1 -
>>   arch/arm64/kernel/irq.c      | 62 -----------------------------------------
>>   include/linux/irq.h          |  4 +++
>>   kernel/irq/migration.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++
>
> This want's to be split into seperate patches:
>
> #1 Provide the core infrastructure
>
> #2 Switch ARM to use it
>
> #3 Switch ARM64 to use it

OK, thanks for suggestion !
I will change it next verison.

Thanks,
Yang
>
> Thanks,
>
> 	tglx
>
> .
>
