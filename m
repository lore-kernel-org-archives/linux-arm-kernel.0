From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Tue, 24 Nov 2009 15:44:02 -0200
Subject: [PATCH] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <20091124172746.GF17481@n2100.arm.linux.org.uk>
References: <37367b3a0911240922m5df3ec4fn7186eceb7c1cd456@mail.gmail.com>
	<20091124172746.GF17481@n2100.arm.linux.org.uk>
Message-ID: <37367b3a0911240944v643c0aabv3d7caf13fadffebc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 11/24/09, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Nov 24, 2009 at 03:22:33PM -0200, Alan Carvalho de Assis wrote:
>> +#include <linux/platform_device.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/map.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mtd/physmap.h>
>> +#include <linux/i2c.h>
>> +#include <linux/irq.h>
>> +#include <mach/common.h>
>> +#include <mach/hardware.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/time.h>
>> +#include <asm/mach/map.h>
>> +#include <mach/gpio.h>
>
> I see red!  linux/gpio.h please.
>

Sure, I based on MX27ADS. I will send a new patch.

Thank you,

Alan
