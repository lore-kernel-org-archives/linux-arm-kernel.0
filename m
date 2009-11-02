From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 2 Nov 2009 11:31:40 -0500
Subject: [PATCH 1/2] ep93xx/micro9.c: fix implicit declaration
	offunction__raw_readl and IOMEM
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901E24EFC@mi8nycmail19.Mi8.com>
References: <1256594665-9837-1-git-send-email-plagnioj@jcrosoft.com>
	<BD79186B4FD85F4B8E60E381CAEE190901E24EFC@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901E84215@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 26, 2009 3:31 PM, H Hartley Sweeten wrote:
> On Monday, October 26, 2009 3:04 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Subject: [PATCH 1/2] ep93xx/micro9.c: fix implicit declaration of function__raw_readl and IOMEM
>> 
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> ---
>>  arch/arm/mach-ep93xx/micro9.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
>> index d83b804..f3757a1 100644
>> --- a/arch/arm/mach-ep93xx/micro9.c
>> +++ b/arch/arm/mach-ep93xx/micro9.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/init.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/mtd/physmap.h>
>> +#include <linux/io.h>
>>  
>>  #include <mach/hardware.h>
>>  
>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> Please add to Russell's Patch Tracker.

Hello Jean-Christophe,

Has this patch been added to Russell's patch tracker yet?

Regards,
Hartley
