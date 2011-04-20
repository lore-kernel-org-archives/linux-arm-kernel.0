From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 17:45:40 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110420163238.5f0e5ea6@lxorguk.ukuu.org.uk>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
	<BANLkTinv-MSg5Sobg2X1cJpAwPkM1Gevcg@mail.gmail.com>
	<BANLkTi=Oc+y+31KugbEy66Mp96=bf_G8Mg@mail.gmail.com>
	<BANLkTinv_-6dJJXAWc=NFTceXGA9sabanA@mail.gmail.com>
	<20110420163238.5f0e5ea6@lxorguk.ukuu.org.uk>
Message-ID: <BANLkTikWrJBDSRL-iJnqFObheeXUwJ7j_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Alan Cox <alan@lxorguk.ukuu.org.uk>:

>> Even if some people are only muxing pins that can also be used as GPIO,
>> this is not always the case. We can shunt out the same pins to be used as
>> I2C or SPI for example, that means this cannot be handled in a GPIO
>> driver since it has nothing to do with GPIO pins at all.
>
> It sounds very much to me like it belongs in the GPIO driver. That is the
> one piece of code which knows what it is doing for all this configuration.

Yeah whether it goes into drivers/pinpadmux and include/linux/pinpadmux.h
or drivers/gpio and include/linux/gpio.h does not matter to me if that is it's
more natural habitat to most people :-)

Now I need to post v2 of this patchset...

Linus Walleij
