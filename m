From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 21 May 2015 09:46:34 +0200
Subject: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
In-Reply-To: <555D1C7D.1060205@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
 <555D1C7D.1060205@suse.de>
Message-ID: <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 1:45 GMT+02:00 Andreas F?rber <afaerber@suse.de>:
> Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>> +      { .compatible = "st,stm32-rcc", },
>> +      { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);
>
> Typo.

Indeed, thanks for pointing this out.

>
> IIUC the timer depends on the reset controller, so it must be built in
> anyway, and that's what's enforced in the Makefile above. Drop the line?
>

Agree it must be built-in.
I will fix that in next version.

Thanks for the review,
Maxime
