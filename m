From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 16 Sep 2014 11:06:37 +0200
Subject: [PATCH v2 5/9] ARM: meson6: clocksource: add Meson6 timer support
In-Reply-To: <3053926.qBD36ymAOD@wuerfel>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-6-git-send-email-carlo@caione.org>
 <3053926.qBD36ymAOD@wuerfel>
Message-ID: <CABuKBeKSkT6k-EaqN17Exf5Qhd6cWJg_qESskrADtRU+_t4-tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-11 22:57 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 11 September 2014 22:11:36 Carlo Caione wrote:
>> Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
>> TIMER_C, TIMER_D and TIMER_E.
>>
>> The driver is providing clocksource support for the 32-bit counter using
>> TIMER_E. Clockevents are also supported using TIMER_A.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>

This version addresses all the comments I had:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> We should take all the platform code through the arm-soc tree, this one
> along with the DT binding document should go through the clocksource
> tree.



-- 
motzblog.wordpress.com
