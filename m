From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 10 Feb 2010 12:50:05 +0800
Subject: [Linux-arm-nuc900] Re: [PATCH]NUC900 clk enable problem fix
In-Reply-To: <71413c851002091833q4f3c88a0u9d36426b5155949c@mail.gmail.com>
References: <71413c851001220404v14c0ae9bq43c926179ef7c599@mail.gmail.com>
	<71413c851002091833q4f3c88a0u9d36426b5155949c@mail.gmail.com>
Message-ID: <e68bb3471002092050p5325445ep278822a5b351ecd0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked.

? 2010?2?10? ??10:33?Qiang Wang <rurality.linux@gmail.com> ???
> hi, Mr Russell
>
> please check and ack this patch.
>
> thank you very much.
>

> best regards
> Wang Qiang
>
> 2010/1/22 Qiang Wang <rurality.linux@gmail.com>:
>> hello, Wan
>>
>> ?There is the patch of nuc900 clk enable problem of timers.
>> ?I tested it ?in 950 env-board, and shell can come correctly.
>>
>>
>>
>> Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
>>
>> ---
>> ?arch/arm/mach-w90x900/cpu.c | ? 10 ++++++++++
>> ?1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
>> index 20dc0c9..dd8e1fd 100644
>> --- a/arch/arm/mach-w90x900/cpu.c
>> +++ b/arch/arm/mach-w90x900/cpu.c
>> @@ -68,6 +68,11 @@ static DEFINE_CLK(gdma, 27);
>> ?static DEFINE_CLK(adc, 28);
>> ?static DEFINE_CLK(usi, 29);
>> ?static DEFINE_CLK(ext, 0);
>> +static DEFINE_CLK(timer0, 19);
>> +static DEFINE_CLK(timer1, 20);
>> +static DEFINE_CLK(timer2, 21);
>> +static DEFINE_CLK(timer3, 22);
>> +static DEFINE_CLK(timer4, 23);
>>
>> ?static struct clk_lookup nuc900_clkregs[] = {
>> ? ? ? ?DEF_CLKLOOK(&clk_lcd, "nuc900-lcd", NULL),
>> @@ -90,6 +95,11 @@ static struct clk_lookup nuc900_clkregs[] = {
>> ? ? ? ?DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
>> ? ? ? ?DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
>> ? ? ? ?DEF_CLKLOOK(&clk_ext, NULL, "ext"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer1, NULL, "timer1"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer2, NULL, "timer2"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer3, NULL, "timer3"),
>> + ? ? ? DEF_CLKLOOK(&clk_timer4, NULL, "timer4"),
>> ?};
>>
>> ?/* Initial serial platform data */
>> --
>> 1.6.6
>>
>
> --
> ????"NUC900 Linux BSP????".
> NUC900 Linux????????????
> NUC900 at googlegroups.com
> ?????????
> NUC900+unsubscribe at googlegroups.com
> ??????????
> https://groups.google.com/group/NUC900?hl=zh-CN
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
