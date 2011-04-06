From: justinmattock@gmail.com (Justin P. Mattock)
Date: Wed, 06 Apr 2011 08:10:36 -0700
Subject: [RFC 1/5]arch/arm/common/Makefile Remove unused config in the
	Makefile.
In-Reply-To: <20110406080522.GZ13963@pengutronix.de>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<20110406080522.GZ13963@pengutronix.de>
Message-ID: <4D9C826C.5050802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:05 AM, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Tue, Apr 05, 2011 at 09:58:18AM -0700, Justin P. Mattock wrote:
>> The patch below removes an unused config variable found by using a kernel
>> cleanup script.
>> Note: I did try to cross compile these but hit erros while doing so..
>> (gcc is not setup to cross compile) and am unsure if anymore needs to be done.
>> Please have a look if/when anybody has free time.
>>
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>> CC: Russell King<linux@arm.linux.org.uk>
>> CC: linux-arm-kernel at lists.infradead.org
> The file was removed by commit
>
> 	6d803ba (ARM: 6483/1: arm&  sh: factorised duplicated clkdev.c)
>
> (added the persons involved to Cc).
>
> Acked-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>
> Thanks
> Uwe

o.k.!! Thanks for having a look at this..

>
>> ---
>>   arch/arm/common/Makefile |    1 -
>>   1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
>> index e7521bca..6ea9b6f 100644
>> --- a/arch/arm/common/Makefile
>> +++ b/arch/arm/common/Makefile
>> @@ -16,5 +16,4 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>>   obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
>>   obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
>>   obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>> -obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
>>   obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
>> --
>> 1.7.4.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>

Justin P. Mattock
