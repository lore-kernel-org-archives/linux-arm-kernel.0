From: bcm@fixthebug.org (Christian Daudt)
Date: Thu, 7 Nov 2013 08:18:11 -0800
Subject: [PATCH 1/3] ARM: bcm: Remove non-existent GENERIC_TIME
In-Reply-To: <CAAYSxhpmvccksRpvmV+F4ywYCraGbscrXNEAtNx3daiMAWxHWw@mail.gmail.com>
References: <1383768156-11414-1-git-send-email-shc_work@mail.ru>
 <CAAYSxhpmvccksRpvmV+F4ywYCraGbscrXNEAtNx3daiMAWxHWw@mail.gmail.com>
Message-ID: <CAEPRUYoX1cm2VQvzGKpA+XHWt=mJN3UCTvEMYZWd94MMT5+tsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 12:26 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Wed, Nov 6, 2013 at 12:02 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> ---
>>  arch/arm/mach-bcm/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index 9fe6d88..7e29ce7 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,7 +19,6 @@ config ARCH_BCM_MOBILE
>>         select CPU_V7
>>         select CLKSRC_OF
>>         select GENERIC_CLOCKEVENTS
>> -       select GENERIC_TIME
>>         select GPIO_BCM_KONA
>>         select SPARSE_IRQ
>>         select TICK_ONESHOT
>> --
>> 1.8.1.5
>>
>
> Nice catch.  Interestingly, a similar fix was posted in March:
>
> https://lkml.org/lkml/2013/3/7/603
>
> CSD reviewed it but apparently didn't take it into his tree.
>
> Possibly an oversight?
>

Oversight indeed. I'll pull the original one in and add Alexander as a
signed-off to it.
 thanks,
   csd
