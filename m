From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 6 Feb 2011 14:22:09 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <20110131075803.GI9041@pengutronix.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<20110129213821.0e51dc32@endymion.delvare>
	<20110129215141.GA3493@pengutronix.de>
	<AANLkTi=ppKZ96T3_1nYisHG9705OCHgZqkLnu2f47zq5@mail.gmail.com>
	<20110131075803.GI9041@pengutronix.de>
Message-ID: <AANLkTi=nDkuevMqY6v_K_Lkoi6wDowcL7AN_a=tb72t5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/31 Sascha Hauer <s.hauer@pengutronix.de>:
> On Sun, Jan 30, 2011 at 11:49:32AM +0800, arden jay wrote:
>> Sorry, I'm confused about this.
>> If it is for backlight control, why it don't go through led_class?
>
> PWMs are not limited to backlight. As Jean pointed out they can be used
> for fans (or more generally motors) aswell. Have a look at
> drivers/leds/leds-pwm.c, it is a user of this pwm API.

Low-frequency PWM is used for vibrators of the type found in
silent mode cellphones, to mention another use case.

Yours,
Linus Walleij
