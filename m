From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 23 Oct 2014 17:14:28 +0400
Subject: [PATCH 1/2] clocksource: enable pxa_timer for SA-1100 platform
In-Reply-To: <10546062.ah0Qvxpsuh@wuerfel>
References: <1413377405-7503-1-git-send-email-dbaryshkov@gmail.com>
 <10546062.ah0Qvxpsuh@wuerfel>
Message-ID: <CALT56yMY=d3b9rodU4_hNmSuf9j0yP+BNPtyzuD_mnPCtDdcnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-20 23:07 GMT+04:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 15 October 2014 16:50:04 Dmitry Eremin-Solenikov wrote:
>> SA-11x0 platform used the same IP block as was used on PXA. Consequently
>> it makes sense to have only one driver. Enable pxa_timer clocksource for
>> StrongARM platform.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Both patches look good to me.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Should we merge them through arm-soc or through the clocksource tree?

I'm fine with any of the approaches. Russell, Daniel, Thomas - any preferences?

-- 
With best wishes
Dmitry
