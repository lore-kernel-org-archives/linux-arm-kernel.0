From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 7 Sep 2015 06:14:52 +0200
Subject: [PATCH v2 00/21] ARM: pxa: magician: Rework HTC Magician support
In-Reply-To: <87fv2txjle.fsf@belgarion.home>
References: <55D2583B.8040602@tul.cz> <87fv2txjle.fsf@belgarion.home>
Message-ID: <55ED0F3C.9040805@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 5.9.2015 v 12:10 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> This patchset will clean, fix and finally add multiple PXA devices
>> to HTC Magician machine. Also it adds leds-pasic3 driver to LED subsystem.
>> This driver require changes into htc-pasic3 structures, which are used
>> exclusively by magician.c code.
>>
>> Petr Cvek (21):
>>   ARM: pxa: magician: Fix Kconfig for magician to always include
>>     htc-egpio
>>   ARM: pxa: magician: Fix indentation and whitespaces
>>   ARM: pxa: magician: Fix comments, debug functions and print strings
>>   ARM: pxa: magician: Add, fix and init (new) GPIOs
>>   ARM: pxa: magician: Add support for ADS7846 touchscreen
>>   ARM: pxa: magician: Add normal and power I2C definition
>>   ARM: pxa: magician: Fix IrDA pdata and redundant GPIO request
>>   ARM: pxa: magician: Add StrataFlash Vpp GPIO and alternative driver
>>   ARM: pxa: magician: Add OV9640 camera support
>>   ARM: pxa: magician: Add UDA1380 sound support
>>   ARM: pxa: magician: Add MAX1586 Vcore regulator support
>>   ARM: pxa: magician: Add PXA27x UDC support
>>   ARM: pxa: magician: Fix charging source and add NiCd backup charging
>>   ARM: pxa: magician: Fix PXA USB OHCI port enable flags
>>   ARM: pxa: magician: Fix PWM backlight regulator
>>   ARM: pxa: magician: Add support for alternative LCD backlight
>>   ARM: pxa: magician: Remove (temporarily) pasic3 LED support
>>   mfd: htc-pasic3: Prepare driver for leds-pasic3
>>   leds: leds-pasic3: Add support for PASIC3 LED controller
>>   ARM: pxa: magician: Re-add pdata for new leds-pasic3 driver
>>   ARM: pxa: magician: Move platform_add_devices() to the end of
>>     magician_init()
> 
> Hi Petr,
> 
> If you want several of these patches targeted at v4.3, I need to know which ones
> (in arch/arm/mach-pxa) are pure fixes without which magician is broken.
> 
> And a confirmation from Philip on this list would make my life easier.
> 

Sorry for delay, I was offline for few days and I have got frozen on creating rootfs suitable for NOR flash.

I will send next patchset soon (this week I hope). 

If it misses this devel window, it is OK to me (I'm no hurry :-D).

Best regards,
Petr


> Cheers.
> 
