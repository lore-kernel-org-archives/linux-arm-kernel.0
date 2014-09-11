From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Thu, 11 Sep 2014 17:51:18 +0530
Subject: [PATCH v3 5/8] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <27455049.omNFrla0xU@wuerfel>
References: <1410430852-3491-1-git-send-email-ch.naveen@samsung.com>
 <1410430852-3491-6-git-send-email-ch.naveen@samsung.com>
 <27455049.omNFrla0xU@wuerfel>
Message-ID: <CAHfPSqBCepBTuz8TDUyYSNKcWu1Umii8A4=Ue=eiBn8X7aiunA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2014 16:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 11 September 2014 15:50:49 Naveen Krishna Chatradhi wrote:
>> +       aliases {
>> +               serial0 = &serial_0;
>> +               serial1 = &serial_1;
>> +               serial2 = &serial_2;
>> +               serial3 = &serial_3;
>> +       };
>> +
>
> Please move the aliases from the exynos7.dtsi file into the
> exynos7-espresso.dts file, and only list the ones that are
> present, starting with alias 0, like
>
>         aliases {
>                 serial0 = &serial_2;
>         };
>
> If the machine has only one serial port, it should be the first
> alias.

Okay, will fix this in the next version.

>
>         Arnd

Thanks,
-- 
Shine bright,
(: Nav :)
