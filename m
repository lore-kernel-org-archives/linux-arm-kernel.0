From: stigge@antcom.de (Roland Stigge)
Date: Sun, 17 Jun 2012 13:51:05 +0200
Subject: [PATCH] leds: Add DT support for leds-pca9532
In-Reply-To: <4FDCA0FC.5000409@wwwdotorg.org>
References: <1339855851-9171-1-git-send-email-stigge@antcom.de>
 <4FDCA0FC.5000409@wwwdotorg.org>
Message-ID: <4FDDC4A9.1040706@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/06/12 17:06, Stephen Warren wrote:
>> +- nxp,typecodes: groups of 2 bits for each of the 16 pins:
>> +  0: None
>> +  1: LED
>> +  2: Beep
>> +  3: GPIO
>> +- nxp,statecodes: groups of 2 bits for each of the 16 pins:
>> +  0: off
>> +  1: on
>> +  2: pwm0
>> +  3: pwm1
>> +
>> +Optional properties:
>> +- nxp,psc: array of 2 numbers: PSC values for the two PWM channels (see datasheet)
>> +- nxp,pwm: array of 2 numbers: PWM values for the two PWM channels (see datasheet)
> 
> Shouldn't that all be exposed using a combination of the pinctrl
> bindings that are in 3.5, and the PWM bindings that should be coming in 3.6?

Thanks for the note! I found a pwm tree that should have this at

http://gitorious.org/linux-pwm/linux-pwm

but it gives me server errors. Is there a place where I can have a look?

Thanks in advance,

Roland
