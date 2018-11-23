From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Nov 2018 15:34:48 +0000
Subject: [PATCH 09/17] irqchip: bcm283x: Switch to SPDX identifier
In-Reply-To: <7ab4438c-6cdd-8655-0745-2bbc137970d0@i2se.com>
References: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
 <7ab4438c-6cdd-8655-0745-2bbc137970d0@i2se.com>
Message-ID: <dda72906-fc11-da81-8aa2-c53639b3dbcc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/2018 15:23, Stefan Wahren wrote:
> Hi Jason,
> hi Marc,
> 
> Am 10.11.18 um 16:54 schrieb Stefan Wahren:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Cc: Simon Arlott <simon@arlott.org>
>> Cc: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/irqchip/irq-bcm2835.c | 11 +----------
>>  drivers/irqchip/irq-bcm2836.c | 11 +----------
>>  2 files changed, 2 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
>> index d2da8a1..418245d 100644
>> --- a/drivers/irqchip/irq-bcm2835.c
>> +++ b/drivers/irqchip/irq-bcm2835.c
>> @@ -1,17 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>>  /*
>>   * Copyright 2010 Broadcom
>>   * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
>>   *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>>   * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
>>   *
>>   * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
>> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
>> index dfe4a46..2038693 100644
>> --- a/drivers/irqchip/irq-bcm2836.c
>> +++ b/drivers/irqchip/irq-bcm2836.c
>> @@ -1,17 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>>  /*
>>   * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
>>   *
>>   * Copyright 2015 Broadcom
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>>   */
>>  
>>  #include <linux/cpu.h>
> 
> Eric already made a review. Are you fine with it?

Sure. How do you want this to go in? If you have a series repainting
multiple subsystems, I'd rather it stays as such, and you can stick my

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

on it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
