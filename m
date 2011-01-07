From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Jan 2011 14:55:50 -0200
Subject: [patch 1/1] mx51: add support for pwm
In-Reply-To: <20110107095839.GD25121@pengutronix.de>
References: <20110107090656.517403682@rtp-net.org>
	<AANLkTin7U0+sJ+Xz7BiJ2NbtiGXsyQbdVKejU9M5qrUp@mail.gmail.com>
	<20110107095839.GD25121@pengutronix.de>
Message-ID: <AANLkTimgYTCme5UtUiUpWH53c+FC1vC=PatGf0eoorsp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

2011/1/7 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
>> Why not follow the arch/arm/plat-mxc/devices/platform-imx-xxx to add
>> devices support?
> good question. ?Note that arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> already exists in Sascha's tree. ?(Maybe now even Linus'.)

I have submitted the following patch for dynamically registering the
PWM on MX51:
http://www.spinics.net/lists/arm-kernel/msg105828.html

I got an ack from Uwe, so it should hit Sascha?s tree soon.

Regards,

Fabio Estevam
