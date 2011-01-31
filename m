From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 08:58:03 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <AANLkTi=ppKZ96T3_1nYisHG9705OCHgZqkLnu2f47zq5@mail.gmail.com>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<20110129213821.0e51dc32@endymion.delvare>
	<20110129215141.GA3493@pengutronix.de>
	<AANLkTi=ppKZ96T3_1nYisHG9705OCHgZqkLnu2f47zq5@mail.gmail.com>
Message-ID: <20110131075803.GI9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 30, 2011 at 11:49:32AM +0800, arden jay wrote:
> Sorry, I'm confused about this.
> If it is for backlight control, why it don't go through led_class?

PWMs are not limited to backlight. As Jean pointed out they can be used
for fans (or more generally motors) aswell. Have a look at
drivers/leds/leds-pwm.c, it is a user of this pwm API.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
