From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 6 Jul 2011 13:13:51 +0530
Subject: [PATCH] ARM: S5PC100: Fix for compilation error
In-Reply-To: <00c201cc3ba6$901a62c0$b04f2840$%kim@samsung.com>
References: <1309801312-27377-1-git-send-email-padma.v@samsung.com>
	<00c201cc3ba6$901a62c0$b04f2840$%kim@samsung.com>
Message-ID: <CAAgF-BdC2qOYdqHJqfO1J-wnm2Ph6M+bhLw2is7RSU_d=qwJ7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wed, Jul 6, 2011 at 12:02 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Padmavathi Venna wrote:
>>
>> From: padmavathi venna <padma.v@samsung.com>
>>
>> S5PC100 Compilation fails without this patch
>>
>> Signed-off-by: padmavathi venna <padma.v@samsung.com>
>> ---
>> ?arch/arm/mach-s5pc100/dev-spi.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pc100/dev-spi.c
> b/arch/arm/mach-s5pc100/dev-spi.c
>> index 2b58c9a..e5d6c4d 100644
>> --- a/arch/arm/mach-s5pc100/dev-spi.c
>> +++ b/arch/arm/mach-s5pc100/dev-spi.c
>> @@ -15,6 +15,7 @@
>> ?#include <mach/dma.h>
>> ?#include <mach/map.h>
>> ?#include <mach/spi-clocks.h>
>> +#include <mach/irqs.h>
>>
>> ?#include <plat/s3c64xx-spi.h>
>> ?#include <plat/gpio-cfg.h>
>> --
>> 1.7.0.4
>
> Ok, will apply in -fix tree.
>
> But, I'm not sure you really need to use your name ' padmavathi venna'
> here...you used "Padmavathi Venna" in other patch.
Thanks for your pointing out. I am going to send a new patch by
removing the parenthesis. In that I will also correct my name.

Thanks&Regards
Padma
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
