From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 10 Feb 2010 12:53:38 +0800
Subject: [Linux-arm-nuc900] Re: [PATCH]NUC900 add gpio virtual memory map
In-Reply-To: <71413c851002091831x101b67a7t9e38e94bbbc95db1@mail.gmail.com>
References: <71413c851002012128l26bbf64fvfffabcae194f076e@mail.gmail.com>
	<71413c851002091831x101b67a7t9e38e94bbbc95db1@mail.gmail.com>
Message-ID: <e68bb3471002092053u7cb5d0aai129538fb32cb4880@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2010?2?10? ??10:31?Qiang Wang <rurality.linux@gmail.com> ???
> hello, Mr Russell
>
> please check and ack this patch.
>
> thank you very much.
>

Hi guy, don't have anxiety,you have to await me to check this issue.

> best regards
> wangqiang
>
> 2010/2/2 Qiang Wang <rurality.linux@gmail.com>:
>> hi, Dear Wan
>>
>> ? This patch adds the gpio registers virtual memory map.
>> ? Without it, the gpio access will cause the "Data Abort" due to no
>> virtual memory assign to it.
>>
>> Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
>> Cc: Wang Zongshun <mcuos.com@gmail.com>
>> ---
>> ?arch/arm/mach-w90x900/cpu.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
>> index 20dc0c9..7a79de0 100644
>> --- a/arch/arm/mach-w90x900/cpu.c
>> +++ b/arch/arm/mach-w90x900/cpu.c
>> @@ -45,6 +45,7 @@ static struct map_desc nuc900_iodesc[] __initdata = {
>> ? ? ? ?IODESC_ENT(UART),
>> ? ? ? ?IODESC_ENT(TIMER),
>> ? ? ? ?IODESC_ENT(EBI),
>> + ? ? ? IODESC_ENT(GPIO),
>> ?};
>>
>> ?/* Initial clock declarations. */
>> --
>> 1.6.4
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
