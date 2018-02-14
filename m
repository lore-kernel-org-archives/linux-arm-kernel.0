From: j-keerthy@ti.com (Keerthy)
Date: Wed, 14 Feb 2018 09:41:23 +0530
Subject: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
In-Reply-To: <20180213150900.GD6364@atomide.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
 <20180213150900.GD6364@atomide.com>
Message-ID: <2f94e782-7925-e42d-d0e1-dbad92f69a83@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 13 February 2018 08:39 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [180213 02:07]:
>> On 01/09/2018 12:23 AM, J, KEERTHY wrote:
>>> The header file is currently under plat-omap directory
>>> under arch/omap. Move this out to an accessible place.
>>> @@ -18,7 +18,7 @@
>>>   #include <linux/platform_data/hsmmc-omap.h>
>>>   #include <linux/platform_data/spi-omap2-mcspi.h>
>>>   #include <linux/omap-dma.h>
>>> -#include <plat/dmtimer.h>
>>> +#include <clocksource/dmtimer.h>
>>
>> These headers are actually not needed in the first-place since we no
>> longer create any non-DT timer devices. I have submitted a series to
>> cleanup the presence of this header file, as part of a larger hwmod data
>> cleanup series.
> 
> OK great. Keerthy, care to take a look? Seems like it
> simplifies things a bit.

Sure Tony. I will look into this.

> 
> Regards,
> 
> Tony
> 
