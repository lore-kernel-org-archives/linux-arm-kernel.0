From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 25 Jan 2013 12:30:40 +0530
Subject: [PATCH 2/4] arm: Move chained_irq_(enter|exit) to a generic file
In-Reply-To: <20130124172919.GI18233@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-3-git-send-email-catalin.marinas@arm.com>
 <5100C759.4070503@ti.com> <20130124172919.GI18233@arm.com>
Message-ID: <51022D98.2060205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 January 2013 10:59 PM, Catalin Marinas wrote:
> On Thu, Jan 24, 2013 at 05:32:09AM +0000, Santosh Shilimkar wrote:
>> On Wednesday 23 January 2013 11:29 PM, Catalin Marinas wrote:
>>> diff --git a/include/linux/irqchip/chained_irq.h b/include/linux/irqchip/chained_irq.h
>>> new file mode 100644
>>> index 0000000..adf4c30
>>> --- /dev/null
>>> +++ b/include/linux/irqchip/chained_irq.h
>>> @@ -0,0 +1,52 @@
>>> +/*
>>> + * Chained IRQ handlers support.
>>> + *
>>> + * Copyright (C) 2011 ARM Ltd.
>>
>> 2013 now ;)
>
> I thought about this but decided to keep the year when the chained IRQ
> functions were contributed by Will (still ARM's copyright).
>
Ahh. Its just move to the new file. As you prefer but 2011-13 will
do as well :-)
