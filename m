From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 6 Nov 2014 11:01:29 +0400
Subject: [PATCH 1/2] clocksource: enable pxa_timer for SA-1100 platform
In-Reply-To: <10546062.ah0Qvxpsuh@wuerfel>
References: <1413377405-7503-1-git-send-email-dbaryshkov@gmail.com>
 <10546062.ah0Qvxpsuh@wuerfel>
Message-ID: <CALT56yOKFcRLZpTHiy-3n8+e=0GY=d_Y9r4ghe_bn5B2vYv+yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

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


Thomas added his blessing (and an ack) to merge these patches through arm-soc.
Should I gather any additional Acks before it cn hit arm-soc/for-next?

-- 
With best wishes
Dmitry
