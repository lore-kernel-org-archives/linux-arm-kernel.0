From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 Mar 2015 11:00:59 +0100
Subject: configuration for nc pins without pull
Message-ID: <20150322100059.GH5664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

for a machine I want to configure a pin that is actually not connected
to minimize floating. (I think this is sensible, isn't it?)

For the pinctrl I can use a hog group of the pinctrl device. At least
one of the pins doesn't have a pullup/pulldown configuration though, so
I want to mux it to its gpio function and set the gpio to output and the
desired value.

Is there something nicer than defining an always-on regulator with gpios
= <&gpio4 3 0> to accomplish that without additional code?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
