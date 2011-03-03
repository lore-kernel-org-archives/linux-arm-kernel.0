From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 3 Mar 2011 11:40:26 +0900
Subject: [PATCH] ARM: S5PC210: add support for i2c PMICs on Universal_C210
	board
In-Reply-To: <20110215113504.GF4152@n2100.arm.linux.org.uk>
References: <1297767555-13326-1-git-send-email-m.szyprowski@samsung.com>
	<20110215113504.GF4152@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimHPzbWpqFMXr2D46VXxLeHaAVTtpeCSaByweu8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 8:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 11:59:15AM +0100, Marek Szyprowski wrote:
>> ?#include <mach/map.h>
>> +#include <mach/gpio.h>
>
> Need I say anything about this?

Hi Russell,

How about to prevent it as compiler error? It's frequent mistake.

At each mach/gpio.h

#ifndef __LINUX_GPIO_H
#error "You should include <linux/gpio.h> instead of <mach/gpio.h>."
#endif

Thank you,
Kyungmin Park

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
