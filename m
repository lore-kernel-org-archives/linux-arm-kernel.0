From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 4 Mar 2015 13:08:02 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <1425411786.2606.24.camel@tiscali.nl>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220195437.GT19388@pengutronix.de>
 <1424468908.24292.10.camel@x220>
 <CALszF6Bm_Y4ZLednjpmP-hMix3gA23FwLm5hViEjr1QojUY+Mg@mail.gmail.com>
 <1425411786.2606.24.camel@tiscali.nl>
Message-ID: <CALszF6AEThPrRe7c7nJ6q7yb2fhLMFuHJUV10sf=w0TMcqVVaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-03 20:43 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:
> Maxime Coquelin schreef op ma 02-03-2015 om 17:53 [+0100]:
>> Do you agree if I define it like this:
>>
>> config ARMV7M_SYSTICK
>>     bool "Clocksource driver for ARMv7-M System timer"
>>     depends on OF && (CPU_V7M || COMPILE_TEST)
>>     select CLKSRC_OF
>>     select CLKSRC_MMIO
>>     help
>>       This options enables clocksource support for the ARMv7-M system
>>       timer unit.
>
> I don't really have strong feelings on whatever way you choose to fix
> the, well, minor problem I pointed out.
>
> Having said that, if a Kconfig entry without a prompt (and therefor,
> without help) actually does what you want it to do, why bother adding a
> prompt and a one line help text?

This is because I added also support for COMPILE_TEST coverage as per
Uwe advice,
and thought it was necessary to have an entry for this.
Maybe I'm just wrong?

Thanks,
Maxime

>
>
> Paul Bolle
>
