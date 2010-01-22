From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 22 Jan 2010 17:23:18 +0800
Subject: [Linux-arm-nuc900] [PATCH] NUC900: add timer 0-4 clk enabling
	definition
In-Reply-To: <71413c851001220103i28610531t5bb8c4189199779d@mail.gmail.com>
References: <4B321EAB.3080606@gmail.com>
	<71413c851001220103i28610531t5bb8c4189199779d@mail.gmail.com>
Message-ID: <e68bb3471001220123u21a0c65cm262222cf6ae4e735@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/22 Qiang Wang <rurality.linux@gmail.com>:
> hello, all
> ?This patch was lost.
> ?It makes our system crash.
>
> To Wan
> ?Can you re-patch it again?
> ?If you do not have time, I can do it for you.

Okay, please.

> wangqiang
>
> 2009/12/23 Wan ZongShun <mcuos.com@gmail.com>:
>> Dear sirs,
>>
>> Li Jie, please re-make your previous patch relative to this.
>>
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>> ---
>> ?arch/arm/mach-w90x900/cpu.c | ? 11 +++++++++++
>> ?1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
>> index 20dc0c9..1192424 100644
>> --- a/arch/arm/mach-w90x900/cpu.c
>> +++ b/arch/arm/mach-w90x900/cpu.c
>> @@ -61,6 +61,11 @@ static DEFINE_CLK(usbd, 8);
>> ?static DEFINE_CLK(usbh, 9);
>> ?static DEFINE_CLK(g2d, 10);;
>> ?static DEFINE_CLK(pwm, 18);
>> +static DEFINE_CLK(timer0, 19);
>> +static DEFINE_CLK(timer1, 20);
>> +static DEFINE_CLK(timer2, 21);
>> +static DEFINE_CLK(timer3, 22);
>> +static DEFINE_CLK(timer4, 23);
>> ?static DEFINE_CLK(ps2, 24);
>> ?static DEFINE_CLK(kpi, 25);
>> ?static DEFINE_CLK(wdt, 26);
>> @@ -90,6 +95,12 @@ static struct clk_lookup nuc900_clkregs[] = {
>> ? ? ? ?DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
>> ? ? ? ?DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
>> ? ? ? ?DEF_CLKLOOK(&clk_ext, NULL, "ext"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer1, NULL, "timer1"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer2, NULL, "timer2"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer3, NULL, "timer3"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer4, NULL, "timer4"),
>> +
>> ?};
>>
>> ?/* Initial serial platform data */
>> --
>> 1.5.6.3
>>
>> --
>> ????"NUC900 Linux BSP?????????".
>> ????NUC900 Linux????????????
>> NUC900 at googlegroups.com
>> ?????????
>> NUC900+unsubscribe at googlegroups.com
>>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
