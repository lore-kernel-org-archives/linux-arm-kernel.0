From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 17:05:27 +0900
Subject: [PATCHv5 4/5] ARM: dts: exynos5420 update the cooling cells for
 core cpu0
In-Reply-To: <CANAwSgTa=7rjcocYocxn+yv6AdH1PVtNu2NTZV6BWgBK3RXCDw@mail.gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-5-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdKtMO3f8YzHXtuZ042jkFRL4wa978=TggSQk8FahubRg@mail.gmail.com>
 <CANAwSgTa=7rjcocYocxn+yv6AdH1PVtNu2NTZV6BWgBK3RXCDw@mail.gmail.com>
Message-ID: <CAJKOXPcxrdkwZmHKfw+YWJ4=XDBTTutK_5-d6SmZ8QQGKyvfCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-13 16:58 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> Hi Krzysztof,
>
> You are correct.
>
> #cooling-cells property are required by the thermal-zone.
>
> http://lxr.free-electrons.com/source/drivers/thermal/of-thermal.c#L607
>
> So I picked this values from earlier series of CPU frequency by Thomas.
>
> Hope this explains the changes. I will update the commit log.

I still don't get it. I do not ask about cooling-cells but levels.

>>> +
>>> +                       cooling-min-level = <10>;
>>> +                       cooling-max-level = <7>;
>>> +                       #cooling-cells = <2>; /* min followed by max */

Which cooling levels are referenced here? Where are they defined?

Please, don't top-post.

Krzysztof
