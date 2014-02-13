From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Feb 2014 07:33:08 +0900
Subject: [PATCH] ARM: S3C24XX: Fix typo "CONFIG_CPUS_3C2443"
In-Reply-To: <CAK9yfHyXmY52KmKPj6=te829-R83dfM7wB813h=+=zCpzzxobA@mail.gmail.com>
References: <1392198068.23759.7.camel@x220>
 <CAK9yfHyXmY52KmKPj6=te829-R83dfM7wB813h=+=zCpzzxobA@mail.gmail.com>
Message-ID: <52FD4824.2020303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/14 18:47, Sachin Kamat wrote:
> On 12 February 2014 15:11, Paul Bolle<pebolle@tiscali.nl>  wrote:
>> Signed-off-by: Paul Bolle<pebolle@tiscali.nl>
>> ---
>> Untested. This needs testing by people with access to knowledge,
>> compilers, and/or hardware related to CPU_S3C2443. I'm not one of them.
>>
>>   arch/arm/mach-s3c24xx/common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
>> index 4adaa4b..1d77d70 100644
>> --- a/arch/arm/mach-s3c24xx/common.c
>> +++ b/arch/arm/mach-s3c24xx/common.c
>> @@ -484,7 +484,7 @@ struct platform_device s3c2440_device_dma = {
>>   };
>>   #endif
>>
>> -#if defined(CONFIG_CPUS_3C2443) || defined(CONFIG_CPU_S3C2416)
>> +#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
>
> This is definitely a typo and the current fix looks good.
>
> Reviewed-by: Sachin Kamat<sachin.kamat@linaro.org>
>
Applied, thanks.

- Kukjin
