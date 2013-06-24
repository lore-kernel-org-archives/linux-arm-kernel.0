From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 12:59:16 +0200
Subject: [PATCH 3/3] ARM: at91/PMC: at91sam9n12 family has USB HS feature
In-Reply-To: <51C82369.1080900@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
 <a3b28f9041482ff60ed0b1b7a6f11d0b1beb5163.1372064763.git.nicolas.ferre@atmel.com>
 <51C82369.1080900@atmel.com>
Message-ID: <51C82684.6090700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/06/2013 12:46, Bo Shen :
> Hi Nicolas,
>
> On 06/24/2013 05:08 PM, Nicolas Ferre wrote:
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>   arch/arm/mach-at91/clock.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
>> index 978de42..1b9bbba 100644
>> --- a/arch/arm/mach-at91/clock.c
>> +++ b/arch/arm/mach-at91/clock.c
>> @@ -88,6 +88,7 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
>>   #define cpu_has_udpfs()        (!(cpu_is_at91sam9rl() \
>>                   || cpu_is_at91sam9g45() \
>>                   || cpu_is_at91sam9x5() \
>> +                || cpu_is_at91sam9n12() \
>>                   || cpu_is_sama5d3()))
>
> The at91sam9n12 don't have USB HS device port feature. It only has USB
> FS device port feature.

OMG! sure ;-)

So I remove this patch from my series (sorry for the noise ;-))

>
>>   #define cpu_has_plladiv2()    (cpu_is_at91sam9g45() \
>>
>
> Best Regards,
> Bo Shen

Thanks! bye.
-- 
Nicolas Ferre
