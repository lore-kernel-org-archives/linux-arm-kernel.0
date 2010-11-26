From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 11:18:06 +0000
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <4CE821BF.7030009@gmail.com>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<4CE821BF.7030009@gmail.com>
Message-ID: <20101126111806.GJ9310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 20, 2010 at 09:30:07PM +0200, Paulius Zaleckas wrote:
>> +#include<linux/kernel.h>
>> +#include<linux/pci.h>
>> +#include<linux/irq.h>
>> +
>> +#include<asm/mach/pci.h>
>> +#include<asm/gpio.h>

linux/gpio.h, not asm/gpio.h please.
